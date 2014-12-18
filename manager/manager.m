function [pr_in, sr_in, wgs_in, sep_in, sep_out, as_in, as_out, ov_in, ov_out, tc] = manager( m_NH3, T_reformer )
%MANAGER - Calculates the mass bilan and tube count of the plant
%
%   This function computes the amounts of CH4, H2O and air needed to
%   produce a certain mass of NH3. It also computes the
%   CO2 emitted, as well as the numbers of tubes needed to fuel the oven
%   and reactor with CH4.
%
%   MANAGER(m_NH3, T_reformer)
%       m_NH3      = the mass of NH3 in metric tons
%       T_reformer = the temperature of the primary reformer

molarmass = molar_masses();
M_NH3 = molarmass(9); % Molar mass of NH3 [kg/mol]
n_NH3 = m_NH3*1e3/M_NH3; % Number of moles of NH3 [mol]

% First, we compute the mass bilan
% Warning, this is not a vector of masses, but a vector of number of moles
mb = mass_bilan(n_NH3, T_reformer);

% We compute the energy bilan based on the mass bilan, that is, the
% number of moles of CH4 needed to heat of the reactants in the reactor, as
% well as the CO2 produced in the reaction.
ch4_oven = energy_bilan(mb, T_reformer);

% We compute the streams for display
[pr_in, sr_in, wgs_in, sep_in, sep_out, as_in, as_out] = mb_intermediary_streams(mb);
[ov_in, ov_out] = eb_intermediary_streams(ch4_oven);

% Finally, we compute the tube count needed for the CH4 flux :
tc = tube_count(mb(1), mb(2), T_reformer);

% We display everything
display_intermediary_streams(pr_in, sr_in, wgs_in, sep_in, sep_out, as_in, as_out, ov_in, ov_out);
fprintf('\n\nOther\n=====\n');
fprintf('\nTubes needed: %d\n', tc);
fprintf('\n');

end

function [pr_in, sr_in, wgs_in, sep_in, sep_out, as_in, as_out] = mb_intermediary_streams(mb)

M = linear_system();

pr_in = (M*(mb.*[1 1 0 0 0 0 0 0 0 0 0 0]'))';

sr_in = (M*(mb.*[1 1 1 0 0 0 0 1 1 0 0 0]'))';

wgs_in = (M*(mb.*[1 1 1 0 0 0 0 1 1 1 0 0]'))';

sep_in = (M*(mb.*[1 1 1 0 0 0 0 1 1 1 1 0]'))';
sep_out = (-M*(mb.*[0 0 0 1 1 0 0 0 0 0 0 0]'))';

as_in = (M*(mb.*[1 1 1 1 1 0 0 1 1 1 1 0]'))';
as_out = (-M*(mb.*[0 0 0 0 0 1 1 0 0 0 0 0]'))';

end

function [ov_in, ov_out] = eb_intermediary_streams(ch4_oven)

ov_in = [ch4_oven, 0, 2*ch4_oven, 0, 0, 0, 0, 0, 0];
ov_out = [0, 2*ch4_oven, 0, 0, 0, 0, ch4_oven, 0, 0];

end

function display_intermediary_streams(pr_in, sr_in, wgs_in, sep_in, ~, as_in, as_out, ov_in, ov_out)

molarmass = molar_masses()./1e3;

fprintf('\nMass bilan\n==========\n');

printtitle('Primary reformer');
printstream('CH4 (in)', pr_in, 1, molarmass);
printstream('H2O (in)', pr_in, 2, molarmass);

printtitle('Secondary reformer');
printstream('CH4 (in)', sr_in, 1, molarmass);
printstream('H2O (in)', sr_in, 2, molarmass);
printstream('CO (in)', sr_in, 6, molarmass);
printstream('CO2 (in)', sr_in, 7, molarmass);
printstream('H2 (in)', sr_in, 8, molarmass);
printstream('O2 (in)', sr_in, 3, molarmass);
printstream('N2 (in)', sr_in, 4, molarmass);
printstream('Ar (in)', sr_in, 5, molarmass);

printtitle('Water-Gas shift');
printstream('CO (in)', wgs_in, 6, molarmass);
printstream('CO2 (in)', wgs_in, 7, molarmass);
printstream('N2 (in)', wgs_in, 4, molarmass);
printstream('H2 (in)', wgs_in, 8, molarmass);
printstream('Ar (in)', wgs_in, 5, molarmass);
printstream('H2O (in)', wgs_in, 2, molarmass);

printtitle('Separation');
printstream('CO2 (in/out)', sep_in, 7, molarmass);
printstream('N2 (in)', sep_in, 4, molarmass);
printstream('H2 (in)', sep_in, 8, molarmass);
printstream('Ar (in)', sep_in, 5, molarmass);
printstream('H2O (in/out)', sep_in, 2, molarmass);

printtitle('Ammonia synthesis');
printstream('H2 (in)', as_in, 8, molarmass);
printstream('N2 (in)', as_in, 4, molarmass);
printstream('Ar (in/out)', as_in, 5, molarmass);
printstream('NH3 (out)', as_out, 9, molarmass);

if any([pr_in, sr_in, wgs_in, sep_in, as_in, as_out, ov_in, ov_out] < -0.01)
    % If one of the flux is negative, we display an error message.
    fprintf('\n**** Error: one of the streams is negative. ****\n')
end

fprintf('\n\nEnergy bilan\n============\n');

printtitle('Oven');
printstream('CH4 (in)',  ov_in, 1, molarmass);
printstream('O2 (in)',   ov_in, 3, molarmass);
printstream('H2O (out)', ov_out, 2, molarmass);
printstream('CO2 (out)', ov_out, 7, molarmass);

end

function printstream(name, moles, idx, molarmass)

fprintf('%-18s%8.2f t/day\t  %8.2f mol/s', name, molarmass(idx)*moles(idx), moles(idx)/(24*60*60));
if moles(idx) < 0
    fprintf(' ****\n');
else
    fprintf('\n');
end

end

function printtitle(title)

fprintf('\n%s\n%s\n', title, repmat('-', 1, length(title)));

end

