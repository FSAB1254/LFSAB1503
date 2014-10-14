function V = linear_solutions()

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
    ]'; % Transposed

% We obtain the vectorial space of the solutions to the homogenous system
V = null(M, 'r');

end