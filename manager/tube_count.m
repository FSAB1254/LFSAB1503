function count = tube_count( n_ch4, n_h2o, T_reformer )

p = 31e5; % Inlet pressure of the primary reformer
R = 8.314; % Perfect gas constant

% We approximate CH4 to a perfect gas and thus use the perfect gas law to
% get its molar volume
count_ch4 = compute_tube_count(n_ch4, R*T_reformer/p);

% Since water is not a perfect gas, we need to use Van der Waals' equation
% a and b Van der Waals coefficients for water
a = 5.536e-1; % [Pa*m^6/mol^2]
b = 0.03049e-3; % [m^3/mol]
count_h2o = compute_tube_count(n_h2o, R^3*T_reformer^3 / (p*R^2*T_reformer^2 + a*p^2) + b);

count = count_ch4 + count_h2o;

end

function count = compute_tube_count( n, molar_volume )

% With the radius of a tube and the speed of the fluid, we compute the
% volumetric flux of a single tube
r = 0.05;
c = 2;
V_1t = pi*r^2*c;

% The molar flux is the amount of moles divided by the number of seconds in
% a day
n_dot = n/86400;

V_tot = n_dot*molar_volume; % Total volumetric flux

count = V_tot/V_1t;
% Better have too many tubes, so if we have something like 80.6 tubes, we
% take 82.
if (count - floor(count)) > 0.5
    count = ceil(count) + 1;
else
    count = ceil(count);
end

end