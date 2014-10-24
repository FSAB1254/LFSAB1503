function n = energy_bilan( mb, T_reformer )

[D_H, D_S] = reactions_dhds(T_reformer);

Q = mb(8)*D_H(1) + mb(9)*D_H(2);

D_H_comb_ch4 = -890e3;

n = -Q/0.75/D_H_comb_ch4;

end
