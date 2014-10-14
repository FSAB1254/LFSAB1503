function [ K1, K2 ] = computeKs( T_reformer )
%COMPUTEKS Computes the equilibrium constants of reactions 1 and 2.

% Reference temperature
T0 = 298.15;

% Standard enthropy at reference temperature of CH4, H2O, CO, CO2 and H2
% [J/mol/K]
% SOURCE: "Principes de Chimie", 2nd edition, Atkins & Jones, de boek
S0 = [186.26 ; 188.83 ; 197.67 ; 213.74 ; 130.68];

% Standard formation enthalpy at reference temperature of CH4, H2O, CO, CO2
% and H2 [J/mol]
% SOURCE: "Principes de Chimie", 2nd edition, Atkins & Jones, de boek
H0f = [-74.81e3 ; -241.82e3 ; -110.53e3 ; -393.51e3 ; 0];

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

K1 = K1(T_reformer);
K2 = K2(T_reformer);

end

