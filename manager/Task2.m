function [OutNH3] = Task2 (a,b,p,T)

% a = # moles de N2
% b = # moles de H2

% # moles à l'équilibre
syms x;
neq = (a+b-2*x);

%Fraction molaire X

XNH3 = x/neq;
XN2 = (a-x/2)/neq;
XH2 = (b-3*x/2)/neq;

%Résoudre pour trouver xi

Q = (XNH3)^2/p^2/XN2/(XH2)^3;
K = computeK([0, 0, -1, 0, 0, 0, 0, -3, 2], T);

OutNH3 = eval(solve(Q == K, x >= 0, x));


    
end





