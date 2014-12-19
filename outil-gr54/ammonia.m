function [OutNH3] = ammonia(n_n2, n_h2, p, T)
%AMMONIA - Computes the NH3 output of the ammonia synthesis reaction at
%equilibrium
%
%   This function computes the amount of NH3 that will be produced in the
%   final reactor, depending on the N2 and H2 inputs, the pressure and the
%   temperature.
%
%   AMMONIA(n_n2, n_h2, p, T)
%       n_n2       = the quantity of N2 in moles
%       n_h2       = the quantity of H2 in moles
%       p          = the pressure inside the reactor in bar
%       T          = the temperature inside the reactor in kelvin

syms x;
% total number of moles at equilibrium
neq = (n_n2+n_h2-2*x);

% Molar fractions
XNH3 = 2*x/neq;
XN2 = (n_n2-x)/neq;
XH2 = (n_h2-3*x)/neq;

Q = (XNH3)^2/XN2/(XH2)^3/p^2;
% Eq. constant
K = computeK([0, 0, 0, -1, 0, 0, 0, -3, 2], T);

% We solve for x
OutNH3 = min(abs(double(solve(Q == K, x >= 0, x < n_n2, x))));

end
