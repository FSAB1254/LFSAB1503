function n = energy_bilan( mb, T_reformer )

[~, ~, H] = thermo_values(T_reformer);

Q = mb(8)*([-1, -1, 0, 0, 0, 1, 0, 3, 0]*H)...
  + mb(9)*([0, -1, 0, 0, 0, -1, 1, 1, 0]*H);

D_H_comb_ch4 = -890e3;

n = -Q/0.75/D_H_comb_ch4;

end
