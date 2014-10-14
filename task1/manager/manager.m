function manager( m_NH3, T_reformer )
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

M_NH3 = 0.017; % Molar mass of NH3 [kg/mol]
n_NH3 = m_NH3*1e3/M_NH3; % Number of moles of NH3 [mol]

% First, we compute the mass bilan
% Warning, this is not a vector of masses, but a vector of number of moles
mb = mass_bilan(n_NH3, T_reformer);

% Then, we compute the energy bilan based on the mass bilan, that is, the
% number of moles of CH4 needed to heat of the reactants in the reactor, as
% well as the CO2 produced in the reaction.
ch4_oven = energy_bilan(mb, T_reformer);
co2_oven = ch4_oven;

% The total bilan is the sum of the two, multiplied by the molar mass and
% divided by 10e3 to obtain tons :
in_ch4_reactor = mb(1) * 0.01604;
in_ch4_oven = ch4_oven * 0.01604;
in_ch4 = in_ch4_reactor + in_ch4_oven;
in_h2o = mb(2) * 0.01802;
in_air = mb(3) * 0.02897;
out_co2 = (mb(4) + co2_oven) * 0.04401;

% Finally, we compute the tube count needed for the CH4 flux :
tc = tube_count(in_ch4_reactor, T_reformer);

fprintf('\nTo produce %d t of ammoniac a day, we need :\n\n', m_NH3/1e3)
fprintf('CH4 :\t %d t (%d t in the reactor and %d t in the oven)\n',...
    in_ch4/1e3, in_ch4_reactor/1e3, in_ch4_oven/1e3)
fprintf('H2O :\t %d t\n', in_h2o/1e3)
fprintf('Air :\t %d t\n\n', in_air/1e3)
fprintf('Besides, that process produces %d t of CO2 a day.\n\n', out_co2/1e3)
fprintf('Finally, we need %d tubes to inject methane in the primary reformer.\n\n', tc)

end

