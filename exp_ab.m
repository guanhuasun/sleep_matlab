function [a_V,a_h_Na,a_n_K,a_h_A,a_m_KS,a_Ca,a_s_AMPA, a_s_NMDA, a_x_NMDA,a_s_GABA,...
   b_V,b_h_Na,b_n_K,b_h_A,b_m_KS,b_Ca,b_s_AMPA, b_s_NMDA, b_x_NMDA,b_s_GABA ] = exp_ab(x_old,g_NMDA,tau_Ca,input_exc,input_inh)

V = x_old(:,1);
h_Na = x_old(:,2);
n_K = x_old(:,3);
h_A = x_old(:,4);
m_KS = x_old(:,5);
C_Ca = x_old(:,6);
s_AMPA = x_old(:,7);
s_NMDA = x_old(:,8);
x_NMDA = x_old(:,9);
s_GABA = x_old(:,10);


if min(h_Na)<0 || min(n_K)<0
    pause
end

C = 1;
A = 0.02;
v_L = -60.95;
V_Na = 55;
V_K = -100;
V_Ca = 120;
K_D = 30;


alphaCa = 0.5;
alpha_n = 0.01 * (V + 34) ./ (1 - exp(-(V + 34) / 10));
if V == -34
    alpha_n = 0.1;
end

beta_n = 0.125 * exp(-(V + 44) / 25);

alpha_m = 0.1 * (V+33) ./ (1 - exp(-(V+33) / 10));
if V == -33
    alpha_m = 1;
end

beta_m = 4 * exp(-(V+53.7)/12);
alpha_h = 0.07 * exp (-(V+50) / 10);
beta_h = 1 ./ (1 + exp(-(V+20) / 10));

g_L = 0.03573;
g_Na = 12.2438;
g_K = 2.61868;
g_A=1.79259;
g_KS=0.0350135;
g_NaP = 0.0717984;
g_AR = 0.0166454;
g_Ca = 0.0256867;
g_KCa = 2.34906;

V_AMPA=0;
V_NMDA=0;
V_GABA=-70;
g_AMPA = 0.513435;

g_GABA = 0.00252916;
%g_GABA=0;
%g_AMPA=0;
%g_NMDA=0;


tau_hA = 15;
tau_mKS = 8 ./ (exp(-(V+55)/30) + exp((V+55)/30));
tau_AMPA=2;
tau_sNMDA=100;
tau_xNMDA=2;
tau_GABA=10;
%tau_Ca=121.403/2; %original value is 121.403
%tau_Ca_list=[121.403/2 121.4*6]; %from wake to sleep
% if wake
%     tau_Ca=121.4/2;
% else
%     tau_Ca=121.4*6;
% end
% if t_sim==59.7
%     pause;
% end
 

m_Nainf = alpha_m./(alpha_m+beta_m);
m_Ainf = 1 ./ (1+ exp(-(V + 50) / 20));
h_Ainf = 1 ./ (1 + exp((V + 80) / 6));
m_KSinf = 1 ./ (1 + exp( -(V + 34)/6.5) );
m_Cainf = 1 ./ (1 + exp(-(V + 20) / 9));
m_KCainf = 1 ./ (1 + (K_D./C_Ca).^3.5);
m_NaPinf = 1 ./ (1 + exp(-(V + 55.7) / 7.7) );
h_ARinf = 1 ./ (1 + exp((V+75)/4));

a_L= g_L .* v_L;
a_Na = g_Na * m_Nainf.^3 .* h_Na .* V_Na;
a_K = g_K * n_K.^4 .* V_K;
a_A = g_A * m_Ainf.^3 .* h_A .* V_K;
a_KS = g_KS .* m_KS .* V_K;
a_Ca = g_Ca .* m_Cainf.^2 .*V_Ca;
I_Ca = g_Ca .* m_Cainf.^2 .* (V - V_Ca);
a_KCa = g_KCa .* m_KCainf .* V_K;
a_NaP = g_NaP * m_NaPinf.^3 .* V_Na;
a_AR = g_AR .* h_ARinf .* V_K;

% I_L= g_L .* (V-v_L);
% I_Na = g_Na * m_Nainf.^3 .* h_Na .* (V-V_Na);
% I_K = g_K * n_K.^4 .* (V-V_K);
% I_A = g_A * m_Ainf.^3 .* h_A .* (V-V_K);
% I_KS = g_KS .* m_KS .* (V-V_K);
% I_Ca = g_Ca .* m_Cainf.^2 .* (V - V_Ca);
% I_KCa = g_KCa .* m_KCainf .* (V-V_K);
% I_NaP = g_NaP * m_NaPinf.^3 .* (V-V_Na);
% I_AR = g_AR .* h_ARinf .* (V-V_K);

a_AMPA = g_AMPA.*s_AMPA.*V_AMPA;
a_NMDA = g_NMDA.*s_NMDA.*V_NMDA;
a_GABA = g_GABA.*s_GABA.*V_GABA;
 
% I_AMPA = g_AMPA.*s_AMPA.*(V-V_AMPA);
 I_NMDA = g_NMDA.*s_NMDA.*(V-V_NMDA);
% I_GABA = g_GABA.*s_GABA.*(V-V_GABA);
% I_syn=I_NMDA+I_GABA+I_AMPA;

a_syn=a_NMDA+a_GABA+a_AMPA;
g_syn=g_AMPA.*s_AMPA+g_NMDA.*s_NMDA+g_GABA.*s_GABA;

a_V=(a_L+a_Na+a_K+a_A+a_KS+a_Ca+a_KCa+a_NaP+a_AR+a_syn/(10*A))/C;
b_V=(g_L+g_Na * m_Nainf.^3 .* h_Na+g_K * n_K.^4 +g_A * m_Ainf.^3.* h_A +...
    g_KS * m_KS+g_Ca * m_Cainf.^2+g_KCa * m_KCainf+ g_NaP * m_NaPinf.^3+g_AR * h_ARinf+g_syn/(10*A))/C;
% 
% dVdt = -(I_L+I_Na+I_K+I_A+I_KS+I_Ca+I_KCa+I_NaP+I_AR)/C...
%     -I_syn/(10*C*A);

a_h_Na=4*alpha_h;b_h_Na=4*(alpha_h+beta_h);
%h_Nadt=4* (alpha_h.*(1-h_Na)-beta_h.*h_Na);
a_n_K=4*alpha_n;b_n_K=4*(alpha_n+beta_n);
%dn_Kdt = 4 * (alpha_n .* (1 - n_K) - beta_n .* n_K);
%dh_Adt = (h_Ainf - h_A)./tau_hA;
a_h_A=h_Ainf/tau_hA;b_h_A=1/tau_hA;
%dm_KSdt = (m_KSinf - m_KS)./tau_mKS;
a_m_KS=m_KSinf./tau_mKS;b_m_KS=1./tau_mKS;
%dCadt = -alphaCa .* (10 * A * I_Ca+I_NMDA) - C_Ca ./ tau_Ca;
a_Ca=-alphaCa * (10 * A * I_Ca+I_NMDA);b_Ca=1 / tau_Ca;

%ds_AMPAdt=3.48*input_exc-s_AMPA./tau_AMPA;
a_s_AMPA=3.48*input_exc;b_s_AMPA=1/tau_AMPA;
%ds_NMDAdt=0.5*x_NMDA.*(1-s_NMDA)-s_NMDA./tau_sNMDA;
a_s_NMDA=0.5*x_NMDA;b_s_NMDA=0.5*x_NMDA+1/tau_sNMDA;
%dx_NMDAdt=3.48*input_exc-x_NMDA./tau_xNMDA;
a_x_NMDA=3.48*input_exc;b_x_NMDA=1./tau_xNMDA;
%ds_GABAdt=input_inh-s_GABA./tau_GABA;
a_s_GABA=input_inh;b_s_GABA=1./tau_GABA;


end