function n = reactions34( n_NH3 )
%REACTIONS12 Computes the inputs and outputs of the reactions 3 and 4
%which take place in the secondary reformer and in the WGS.

n_N2 = (1/2)*n_NH3;
n_air = n_N2 / 0.7808;
n_O2 = 0.2095*n_air;

% Stoechiometric coefs. of CH4, air and H2O in the sum of the two
% reactions
coefs = [-2, -(1/0.2095), -2, 6];

% Number of moles of CH4, H2O and air needed, and H2 produced [mol]
n = n_O2 * coefs;

end

