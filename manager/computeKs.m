function [ K1, K2 ] = computeKs( T_reformer )
%COMPUTEKS Computes the equilibrium constants of reactions 1 and 2.

R = 8.314; % Perfect gas constant

[D_H, D_S] = reactions_dhds(T_reformer);

% Equilibrium constant
K1 = exp(D_S(1)/R - D_H(1)/R/T_reformer);
K2 = exp(D_S(2)/R - D_H(2)/R/T_reformer);

end

