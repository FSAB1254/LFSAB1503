function count = tube_count( m_ch4, T_reformer )

M = 0.016;
p = 31e5;
R = 8.314;
rho = M*p/R/T_reformer;

r = 0.05;
c = 2;
V_1t = pi*r^2*c;

m_dot = m_ch4/86400;

V_tot = m_dot/rho;

count = ceil(V_tot/V_1t);

end

