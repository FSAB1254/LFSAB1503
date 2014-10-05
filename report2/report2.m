function report2
T0 = 298.15; % Reference temperature

% Standard enthropy at reference temperature of CH4, H2O, CO and H2
% (J/mol/K)
% SOURCE: "Principes de Chimie", 2nd edition, Atkins & Jones, de boek
S0 = [186.26 ; 188.83 ; 197.67 ; 130.68];

% Standard formation enthalpy at reference temperature of CH4, H2O, CO and
% H2 (J/mol)
% SOURCE: "Principes de Chimie", 2nd edition, Atkins & Jones, de boek
H0f = [-74.81e3 ; -228.57e3 ; -137.17e3 ; 0];

% Specific heat of CH4, H2O, CO and H2 (J/mol/K) (fct of the temperature)
% SOURCE: http://www.edu.upmc.fr/chimie/lc101-202-301/communs/public/capcalo.htm
Cp = @(T) [
    14.23 + 75.3e-3*T - 18.00e-6*T.^2 ;
    30.13 + 10.46e-3*T ;
    27.62 + 5.02e-3*T ;
    29.30 - 0.84e-3*T + 2.08e-6*T.^2
    ];

% Stoechiometric coefficents of CH4, H2O, CO and H2 (reagents are negative;
% products are positive)
C = [-1 -1 1 3];

K = eqconst(T0, C*S0, C*H0f, @(T) C*Cp(T));

K(1080) % K at 1080K

% p = 31;
% n = 1.0579;
% n1 = 0.4421;
% n2 = 0.6158;
% a = p*n1/n;
% b = p*n2/n;
% poly = [9*K(1080) 0 -1 (a+b) -a*b];
% 
% roots(poly)

end

function K = eqconst(T0, D_S0, D_H0, D_Cp)
% EQCONST Computes and returns the equilibrium constant K as a function of
% the temperature. Assumes no phase transition has to occur to go from T0
% to T.

R = 8.314; % Perfect gas constant

% Entropy delta (fct of the temperature)
D_S = @(T) D_S0 + integral(@(X) D_Cp(X)./X, T0, T);

% Enthaply delta (fct of the temperature)
D_H = @(T) D_H0 + integral(D_Cp, T0, T);

% Equilibrium constant (fct of the temperature)
K = @(T) exp(D_S(T)/R - D_H(T)/R/T);
end

