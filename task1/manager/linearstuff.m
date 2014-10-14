
E = num2cell(eye(9), 2);
[CH4, H2O, O2,  N2,  Ar,  CO,  CO2, H2,  NH3] = deal(E{:});

% R1:  CH4(g) + H2O(g) <=>  CO(g)  + 3H2(g)
% R2:  CO(g)  + H2O(g) <=>  CO2(g) +  H2(g)
% R3: 2CH4(g) + O2(g)  --> 2CO(g)  + 4H2(g)
% R4:  CO(g   + H2O(g) -->  CO2(g) +  H2(g)
% R5: (1/2)N2(g) + (3/2)H2(g) --> NH3(g)

% Note: 1 Air = 0.78 N2 + 0.21 O2 + 0.01 Ar

M = [
    CH4 ;
    H2O ;
    0.21*O2 + 0.78*N2 + 0.01*Ar ;
    -CO2 ;
    -H2O ;
    -Ar ;
    -NH3 ;
    - CH4 - H2O + CO + 3*H2 ;
    - CO - H2O + CO2 + H2 ;
    - 2*CH4 - O2 + 2*CO + 4*H2 ;
    - CO - H2O + CO2 + H2 ;
    - 0.5*N2 - 1.5*H2 + NH3
    ]';
    
%   CH4, H2O, O2,  N2,  Ar,  CO,  CO2, H2,  NH3
M = [ 
    1    0    0    0    0    0    0    0    0 ; % In(CH4)
    0    1    0    0    0    0    0    0    0 ; % In(H2O)
    0    0    0.21 0.78 0.01 0    0    0    0 ; % In(Air)
    0    0    0    0    0    0   -1    0    0 ; % Out(CO2)
    0   -1    0    0    0    0    0    0    0 ; % Out(H2O)
    0    0    0    0   -1    0    0    0    0 ; % Out(Ar)
    0    0    0    0    0    0    0    0   -1 ; % Out(NH3)
   -1   -1    0    0    0    1    0    3    0 ; % R1
    0   -1    0    0    0   -1    1    1    0 ; % R2
   -2    0   -1    0    0    2    0    4    0 ; % R3
    0   -1    0    0    0   -1    1    1    0 ; % R4
    0    0    0   -1    0    0    0   -3    2   % R5
    ]';

N = null(M, 'r')

eq_components = [
1 0 0 0 0 0 0 -1 0 0 0 0; % CH4
0 1 0 0 0 0 0 -1 -1 0 0 0; % H2O
0 0 0 0 0 0 0 1 -1 0 0 0; % CO
0 0 0 0 0 0 0 0 1 0 0 0; % CO2
0 0 0 0 0 0 0 3 1 0 0 0; % H2
];

m_NH3 = 1.5e6;
M_NH3 = 0.017; % Molar mass of NH3 [kg/mol]
n_NH3 = m_NH3/M_NH3; % Number of moles of NH3 [mol]

K1 = 26.8696;
K2 = 1.3147;

syms a b c real;

W = N * [a;b;c];
c = solve(W(7) == n_NH3, c);

V = eq_components * N * [a;b;c];
a = solve(V(4)*V(5)/V(3)/V(2) == K2, a);

V = eq_components * N * [a;b;c];
b = solve(V(3)*V(5)^3/V(1)/V(2)/sum(V)^2 == K1*29^2, V(3) >= 0, b);
b = double(b);
a = eval(a);
c = double(c);

N*[a;b;c]

