function sol = mass_bilan( n_NH3, T_reformer )

% First we resolve the linear dependencies between the variables
V = linear_solutions();

% Then we compute the equilibrium constants
[K1, K2] = computeKs(T_reformer);
p_tot = 26;
Kp1 = K1 / p_tot^2;
Kp2 = K2;

% This matrice is used to get the number of moles of the different
% chemicals in the reactor, based on the advancement table
activities_coefs = [
1 0 0 0 0 0 0 -1  0 0 0 0; % CH4
0 1 0 0 0 0 0 -1 -1 0 0 0; % H2O
0 0 0 0 0 0 0  1 -1 0 0 0; % CO
0 0 0 0 0 0 0  0  1 0 0 0; % CO2
0 0 0 0 0 0 0  3  1 0 0 0; % H2
];

% The tricky part is solving the non-linear equations with Matlab. To do
% this, we perform symbolic calculations, where a, b and c are the
% coefficients of the bases of the vectorial space of solutions, so that :
% sol = a*v1 + b*v2 + c*v3
syms a b c real;

% First equation: the amount of NH3 that goes out must be equal to the
% amount we want to produce
v = V * [a;b;c];
c = solve(v(7) == n_NH3, c);

% Second equation: the one corresponding to the second equilibrium
% constant. The reason we resolve this one first is because the other one
% is much more complexe, and Matlab would have troubles digesting it.
w = activities_coefs * V * [a;b;c];
a = solve(w(4)*w(5) / w(3)/w(2) == Kp2, a);

% Third equation: the one corresponding to the first equilibrium constant.
w = activities_coefs * V * [a;b;c];
b = solve(w(3)*w(5)^3 / w(1)/w(2)/sum(w)^2 == Kp1, w(3) >= 0, b);

b = double(b);
a = eval(a);
c = double(c);

% Finally, the solution is ours!
sol = V*[a;b;c];

end

