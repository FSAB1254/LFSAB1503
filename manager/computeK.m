function K = computeK(Coef,  T)
%COMPUTEK Computes an equilibrium constant

R = 8.314; % Perfect gas constant

[~, S, H] = thermo_values(T);

% Equilibrium constant
K = exp(Coef*S/R - Coef*H/R/T);

end

