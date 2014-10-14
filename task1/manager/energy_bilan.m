function n = energy_bilan( mb, T_reformer )

% Reference temperature
T0 = 298.15;

% Specific heat of CH4, H2O, CO, CO2 and H2 [J/mol/K] (fct of the temperature)
% SOURCE: http://www.edu.upmc.fr/chimie/lc101-202-301/communs/public/capcalo.htm
Cpm_ch4 = @(T) 14.23 + 75.3e-3*T - 18.00e-6*T.^2 ;

Cpm_O2 =  @(T) 25.73 + 12.97e-3*T - 3.77e-6*T.^2 ;
Cpm_N2 =  @(T) 27.62 + 4.19e-3*T ;
Cpm_Ar =       12.47 ;
Cpm_air = @(T) 0.21 * Cpm_O2(T) + 0.078 * Cpm_N2(T) + 0.01 * Cpm_Ar ;

Cpm_h2o_l = @(T) 28.07 - 0.2817*T + 1.25e-3*T.^2 - 2.48e-6*T.^3 + 1.857e-6*T.^4;
Cpm_h2o_g = @(T) 30.13 + 10.46e-3*T ;
D_Hm_vap_h2o = 40.67e3 ;

Q_ch4 = mb(1) * integral(Cpm_ch4, T0, T_reformer);
Q_air = mb(3) * integral(Cpm_air, T0, T_reformer);
Q_h2o = mb(1) * (integral(Cpm_h2o_l, T0, 293) + integral(Cpm_h2o_g, 293, T_reformer) + D_Hm_vap_h2o);

Q = Q_ch4 + Q_air + Q_h2o;

D_H_comb_ch4 = -890e3;

n = -Q/0.75/D_H_comb_ch4;

end

