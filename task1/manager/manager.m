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

if any(mb < 0)
    % If one of the flux is negative, we display an error message.
    fprintf('\nError: one of the flux is negative.\n')
    fprintf('Here are the details of the molar fluxes :\n\n')
    fprintf(errorstring(mb(1) > 0, 'In(CH4) = %6.2f'), mb(1))
    fprintf(errorstring(mb(2) > 0, 'In(H2O) = %6.2f'), mb(2))
    fprintf(errorstring(mb(3) > 0, 'In(Air) = %6.2f'), mb(3))
    fprintf(errorstring(mb(4) > 0, 'Out(CO2) = %6.2f'), mb(4))
    fprintf(errorstring(mb(5) > 0, 'Out(H2O) = %6.2f'), mb(5))
    fprintf(errorstring(mb(6) > 0, 'Out(Ar) = %6.2f'), mb(6))
    fprintf(errorstring(mb(7) > 0, 'Out(NH3) = %6.2f'), mb(7))
    fprintf(errorstring(mb(8) > 0, 'R1 = %6.2f'), mb(8))
    fprintf(errorstring(mb(9) > 0, 'R2 = %6.2f'), mb(9))
    fprintf(errorstring(mb(10) > 0, 'R3 = %6.2f'), mb(10))
    fprintf(errorstring(mb(11) > 0, 'R4 = %6.2f'), mb(11))
    fprintf(errorstring(mb(12) > 0, 'R5 = %6.2f'), mb(12))
else
    % Otherwise, we compute the energy bilan based on the mass bilan, that is, the
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
    out_co2_reactor = mb(4) * 0.04401;
    out_co2_oven = co2_oven * 0.04401;
    out_co2 = out_co2_reactor + out_co2_oven;

    % Finally, we compute the tube count needed for the CH4 flux :
    tc = tube_count(mb(1), mb(2), T_reformer);

    fprintf('\nTo produce %4.f t of ammoniac a day, we need :\n\n', m_NH3)
    fprintf('CH4 :\t %7.2f t (%6.2f t in the reactor and %6.2f t in the oven)\n',...
        in_ch4/1e3, in_ch4_reactor/1e3, in_ch4_oven/1e3)
    fprintf('H2O :\t %6.2f t\n', in_h2o/1e3)
    fprintf('Air :\t %6.2f t\n\n', in_air/1e3)
    fprintf('Besides, that process produces %6.2f t of CO2 a day (%6.2f t in the reactor and %6.2f t in the oven).\n\n',...
        out_co2/1e3, out_co2_reactor/1e3, out_co2_oven/1e3)
    fprintf('Finally, we need %3.f tubes to inject methane in the primary reformer.\n\n', tc)
end

end

function str = errorstring(cond, msg)
%ERRORSTRING - Returns string with red coloring if a condition is false.

if cond
    str = [msg, '\n'];
else
    str = ['**** ', msg, ' ****\n'];
end

end

