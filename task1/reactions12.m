function n = reactions12( n_NH3, T_reformer, n_CH4_34, n_H2_34 )
%REACTIONS12 Computes the inputs and outputs of the reactions 1 and 2
%which take place in the steam reformer.

% The number of moles of H2 we need to produced in reactions 1 and 2
% depends on the number of moles produced in reactions 3 and 4
n_H2_12 = (3/2)*n_NH3 - n_H2_34;

% Equilibrium constants of reactions 1 and 2
[K1, K2] = computeKs(T_reformer);

p = 29; % Average pressure in reactor [bar]
p0 = 1; % Reference pressure [bar]

syms a b c d real;
n_tot = a + b + 2*c; % Total number of moles of gas in the reactor

% Mole fraction of the different gases in the reactor
xi_CH4 = (a - c)/n_tot;
xi_H2O = (b - c - d)/n_tot;
xi_CO = (c - d)/n_tot;
xi_CO2 = (d)/n_tot;
xi_H2 = (3*c + d)/n_tot;

% Equilibrium constants
eqs(1) = (xi_CO * xi_H2^3 / xi_CH4 / xi_H2O * (p/p0)^2) == K1;
eqs(2) = (xi_CO2 * xi_H2 / xi_CO / xi_H2O) == K2;
% The number of moles of H2 produced is fixed
eqs(3) = xi_H2*n_tot == n_H2_12;
% The number of moles of CH4 left after the reaction is fixed
eqs(4) = xi_CH4*n_tot == n_CH4_34;

[a, b, c, d] = solve(eqs, a, b, c, d);

% Number of moles of CH4, H2O and air needed, and H2 produced [mol]
n = [
    eval(-c)
    eval(-c -d)
    0
    eval(3*c + d)
    ]';

end

