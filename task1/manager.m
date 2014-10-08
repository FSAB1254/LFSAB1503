function manager(m_NH3, T_reformer)

T0 = 298.15;

% Standard enthropy at reference temperature of CH4, H2O, CO, CO2 and H2
% [J/mol/K]
% SOURCE: "Principes de Chimie", 2nd edition, Atkins & Jones, de boek
S0 = [186.26 ; 188.83 ; 197.67 ; 213.74 ; 130.68];

% Standard formation enthalpy at reference temperature of CH4, H2O, CO, CO2
% and H2 [J/mol]
% SOURCE: "Principes de Chimie", 2nd edition, Atkins & Jones, de boek
H0f = [-74.81e3 ; -228.57e3 ; -137.17e3 ; -393.51e3 ; 0];

% Specific heat of CH4, H2O, CO, CO2 and H2 [J/mol/K] (fct of the temperature)
% SOURCE: http://www.edu.upmc.fr/chimie/lc101-202-301/communs/public/capcalo.htm
Cp = @(T) [
    14.23 + 75.3e-3*T - 18.00e-6*T.^2 ;
    30.13 + 10.46e-3*T ;
    27.62 + 5.02e-3*T ;
    32.22 + 22.18e-3*T - 3.34e-6*T.^2 ;
    29.30 - 0.84e-3*T + 2.08e-6*T.^2
    ];

% Stoechiometric coefficents of CH4, H2O, CO, CO2 and H2 (reagents are negative;
% products are positive)
C1 = [-1 -1 1 0 3]; % First reaction
C2 = [0 -1 -1 1 1]; % Second reaction

K1 = K(T0, C1*S0, C1*H0f, @(T) C1*Cp(T));
K2 = K(T0, C2*S0, C2*H0f, @(T) C2*Cp(T));


K1 = K1(T_reformer) % K1 at T_reformer
K2 = K2(T_reformer) % K2 at T_reformer

M_NH3 = 0.017; % Molar mass of NH3 [kg/mol]
n_NH3 = m_NH3*1e3/M_NH3; % Number of moles of NH3 [mol]

% Number of moles of H2 that have to be produced in reactions 1 and 2 [mol]
n_H2_12 = 0.6948*n_NH3;
% Number of moles of CH2 that have to be left after reactions 1 in order to
% fuel reaction 3 [mol]
n_CH4_34 = 0.2684*n_NH3;

syms a b c d real;

p = 29; % Average pressure in reactor [bar]
p0 = 1; % Reference pressure [bar]
n_tot = a + b + 2*c;
xi_CH4 = (a - c)/n_tot;
xi_H2O = (b - c - d)/n_tot;
xi_CO = (c - d)/n_tot;
xi_CO2 = (d)/n_tot;
xi_H2 = (3*c + d)/n_tot;

eqs(1) = (xi_CO * xi_H2^3 / xi_CH4 / xi_H2O * (p/p0)^2) == K1;
eqs(2) = (xi_CO2 * xi_H2 / xi_CO / xi_H2O) == K2;
eqs(3) = xi_H2*n_tot == n_H2_12;
eqs(4) = xi_CH4*n_tot == n_CH4_34;

[a, b, c, d] = solve(eqs, a, b, c, d);

eval(xi_CH4)
eval(xi_H2O)
eval(xi_CO2)

end

% Prog: solve systems
