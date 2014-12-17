function [EbOv, EbOt, MbPr, MbSr, MbWGs, MbS, MbAs, MbO, mb, ch4_oven, tc] = manager( m_NH3, T_reformer )
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

% Finally, we compute the tube count needed for the CH4 flux :
tc = tube_count(mb(1), mb(2), T_reformer);

% We display everything
fprintf('\nMass bilan\n==========\n');
[MbPr, MbSr, MbWGs, MbS, MbAs, MbO] = displaymb(mb);

fprintf('\n\nEnergy bilan\n============\n');
printtitle('Oven');
EbOv = [ch4_oven*molarmass(1)/1e3, ch4_oven*2*molarmass(3)/1e3, ch4_oven*2*molarmass(2)/1e3, ch4_oven*molarmass(7)/1e3];
printstream('CH4 (in)',  EbOv(1), ch4_oven);
printstream('O2 (in)',   EbOv(2), ch4_oven*2);
printstream('H2O (out)', EbOv(3), ch4_oven*2);
printstream('CO2 (out)', EbOv(4), ch4_oven);

fprintf('\n\nOther\n=====\n');
EbOt = tc;
fprintf('\nTubes needed: %d\n', tc);

fprintf('\n');

end

function [MbPr, MbSr, MbWGs, MbS, MbAs, MbO] = displaymb(mb)

M = linear_system();
molarmass = molar_masses()./1e3;

printtitle('Primary reformer');
moles = M*(mb.*[1 1 0 0 0 0 0 0 0 0 0 0]');
mass = molarmass.*moles;
MbPr = mass(1:2);
printstream('CH4 (in)', mass(1), moles(1));
printstream('H2O (in)', mass(2), moles(2));

printtitle('Secondary reformer');
moles = M*(mb.*[1 1 1 0 0 0 0 1 1 0 0 0]');
mass = molarmass.*moles;
size(mass)
size([1 1 1 1 1 1 1 1 0])
MbSr = [mass' .* [1 1 1 1 1 1 1 1 0], 0, 0,0];
printstream('CH4 (in)', mass(1), moles(1));
printstream('H2O (in)', mass(2), moles(2));
printstream('CO (in)', mass(6), moles(6));
printstream('CO2 (in)', mass(7), moles(7));
printstream('H2 (in)', mass(8), moles(8));
printstream('O2 (in)', mass(3), moles(3));
printstream('N2 (in)', mass(4), moles(4));
printstream('Ar (in)', mass(5), moles(5));

printtitle('Water-Gas shift');
moles = M*(mb.*[1 1 1 0 0 0 0 1 1 1 0 0]');
mass = molarmass.*moles;
MbWGs = mass([6,7,4,8,5,2]);
printstream('CO (in)', mass(6), moles(6));
printstream('CO2 (in)', mass(7), moles(7));
printstream('N2 (in)', mass(4), moles(4));
printstream('H2 (in)', mass(8), moles(8));
printstream('Ar (in)', mass(5), moles(5));
printstream('H2O (in)', mass(2), moles(2));

printtitle('Separation');
moles = M*(mb.*[1 1 1 0 0 0 0 1 1 1 1 0]');
mass = molarmass.*moles;
MbS = mass([7,4,8,5,2]);
printstream('CO2 (in/out)', mass(7), moles(7));
printstream('N2 (in)', mass(4), moles(4));
printstream('H2 (in)', mass(8), moles(8));
printstream('Ar (in)', mass(5), moles(5));
printstream('H2O (in/out)', mass(2), moles(2));

printtitle('Ammonia synthesis');
moles = M*(mb.*[1 1 1 1 1 0 0 1 1 1 1 0]');
mass = molarmass.*moles;
MbAs = mass([8,4,5]);
printstream('H2 (in)', mass(8), moles(8));
printstream('N2 (in)', mass(4), moles(4));
printstream('Ar (in/out)', mass(5), moles(5));

printtitle('Output');
moles = M*(mb.*[1 1 1 1 1 1 0 1 1 1 1 1]');
mass = molarmass.*moles;
MbO = mass(9);
printstream('NH3 (out)', mass(9), moles(9));

if any(mb < 0)
    % If one of the flux is negative, we display an error message.
    fprintf('\n**** Error: one of the streams is negative. ****\n')
end

end

function printstream(name, mass, moles)

fprintf('%-18s%8.2f t/day\t  %8.2f mol/s', name, mass, moles/(24*60*60));
if mass < 0
    fprintf(' ****\n');
else
    fprintf('\n');
end

end

function printtitle(title)

fprintf('\n%s\n%s\n', title, repmat('-', 1, length(title)));

end

