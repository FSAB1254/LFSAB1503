function K = K( T0, D_S0, D_H0, D_Cp )
%K Computes and returns the equilibrium constant K as a function of
%the temperature. Assumes no phase transition has to occur to go from T0
%to T.

R = 8.314; % Perfect gas constant

% Entropy delta (fct of the temperature)
D_S = @(T) D_S0 + integral(@(t) D_Cp(t)./t, T0, T);

% Enthaply delta (fct of the temperature)
D_H = @(T) D_H0 + integral(D_Cp, T0, T);

% Equilibrium constant (fct of the temperature)
K = @(T) exp(D_S(T)/R - D_H(T)/R/T);
end

