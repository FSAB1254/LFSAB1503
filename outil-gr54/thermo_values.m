function [Cp, S, H] = thermo_values(T)

% Reference temperature
T0 = 298.15;

% Each vector has values for the following molecules in that order:
% CH4, H2O, O2, N2, Ar, CO, CO2, H2, NH3

% Standard enthropy at reference temperature [J/mol/K]
% Note: Argon was not given, but is not used anyway
% SOURCE: "Principes de Chimie", 2nd edition, Atkins & Jones, de boek
S0 = [186.26 ; 188.83 ; 205 ; 192 ; 0 ; 197.67 ; 213.74 ; 130.68 ; 193];

% Standard formation enthalpy at reference temperature [J/mol]
% SOURCE: "Principes de Chimie", 2nd edition, Atkins & Jones, de boek
H0f = [-74.81e3 ; -241.82e3 ; 0 ; 0 ; 0 ; -110.53e3 ; -393.51e3 ; 0 ; -46e3];

% Specific heat of CH4, H2O, CO, CO2 and H2 [J/mol/K] (fct of the temperature)
% Note: Argon was not given, but is not used anyway
% SOURCE: http://www.edu.upmc.fr/chimie/lc101-202-301/communs/public/capcalo.htm
Cp = @(T) [
    14.23 + 75.3e-3*T - 18.00e-6*T.^2 ;
    30.13 + 10.46e-3*T ;
    25.73 + 12.97e-3*T - 377e-6*T.^2 ;
    27.62 + 4.19e-3*T ;
    0 ;
    27.62 + 5.02e-3*T ;
    32.22 + 22.18e-3*T - 3.34e-6*T.^2 ;
    29.30 - 0.84e-3*T + 2.08e-6*T.^2 ;
    31.81 - 15.48e-3*T + 5.86e-6*T.^2
    ];

S = S0 + integral(@(t) Cp(t)./t, T0, T, 'ArrayValued', true);
H = H0f + integral(Cp, T0, T, 'ArrayValued', true);

end