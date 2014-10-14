function manager( m_NH3, T_reformer )

% Molar masses of CH4, H2O, air and H2 [kg/mol]
M = [0.016, 0.018, 0.02897, 0.002];
M_NH3 = 0.017; % Molar mass of NH3 [kg/mol]
n_NH3 = m_NH3*1e3/M_NH3; % Number of moles of NH3 [mol]

% Number of moles of CH4, H2O and air needed, and H2 produced in reactions
% 3 and 4, and in reactions 1 and 2 [mol]
n34 = reactions34(n_NH3)
n12 = reactions12(n_NH3, T_reformer, -n34(1), n34(4))

n = n12 + n34;
m = M .* n;

m(4) = m_NH3*1e3;
% Mass of CH4, H2O and air needed, and NH3 produced [t]
n
m

end

