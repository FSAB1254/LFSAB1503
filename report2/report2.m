function report1
% SOURCE: http://www.edu.upmc.fr/chimie/lc101-202-301/communs/public/capcalo.htm
Cp_CH4 = @(T) 14.23 + 75.3e-3*T - 18.00e-6*T.^2;
Cp_H2O = @(T) 30.13 + 10.46e-3*T;
Cp_CO = @(T) 27.62 + 5.02e-3*T;
Cp_H2 = @(T) 29.30 - 0.84e-3*T + 2.08e-6*T.^2;


T0 = 298.15; % Reference temperature
D_S0 = (197.67 + 3*130.68) - (186.26 + 188.83); % Entropy delta at reference temperature
D_H0 = (-137.17e3 + 3*0) - (-74.81e3 - 228.57e3); % Enthalpy delta at reference temperature
D_Cp = @(T) (Cp_CO(T) + 3*Cp_H2(T)) - (Cp_CH4(T) + Cp_H2O(T)); % Specific heat of products - reagents (fct of the temperature)

K = eqconst(T0, D_S0, D_H0, D_Cp);

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

R = 8.314; % Perfact gas constant

% Entropy delta (fct of the temperature)
D_S = @(T) D_S0 + integral(@(T) D_Cp(T)./T, T0, T);

% Enthaply delta (fct of the temperature)
D_H = @(T) D_H0 + integral(D_Cp, T0, T);

% Equilibrium constant (fct of the temperature)
K = @(T) exp(D_S(T)/R - D_H(T)/R/T);
end

