function [vel] = an_dynamic(x,g_NMDA,tau_Ca,input_exc,input_inh,sigma_noise)%,N_neuron,old_fire_ind,with_noise)

%SAN model without input
%   x:  dimension x = (V,h_Na,n_K,h_A,m_Ks,C_Ca,s_AMPA, s_NMDA, x_NMDA, s_GABA)
%   t: time, not used.
%   Y: coupling strength

V = x(:,1);
h_Na = x(:,2);
n_K = x(:,3);
h_A = x(:,4);
m_KS = x(:,5);
C_Ca = x(:,6);
s_AMPA = x(:,7);
s_NMDA = x(:,8);
x_NMDA = x(:,9);
s_GABA = x(:,10);

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

tau_hA = 15;
tau_mKS = 8 ./ (exp(-(V+55)/30) + exp((V+55)/30));
tau_AMPA=2;
tau_sNMDA=100;
tau_xNMDA=2;
tau_GABA=10;
 

m_Nainf = alpha_m./(alpha_m+beta_m);
m_Ainf = 1 ./ (1+ exp(-(V + 50) / 20));
h_Ainf = 1 ./ (1 + exp((V + 80) / 6));
m_KSinf = 1 ./ (1 + exp( -(V + 34)/6.5) );
m_Cainf = 1 ./ (1 + exp(-(V + 20) / 9));
m_KCainf = 1 ./ (1 + (K_D./C_Ca).^3.5);
m_NaPinf = 1 ./ (1 + exp(-(V + 55.7) / 7.7) );
h_ARinf = 1 ./ (1 + exp((V+75)/4));

I_L= g_L .* (V-v_L);
I_Na = g_Na * m_Nainf.^3 .* h_Na .* (V-V_Na);
I_K = g_K * n_K.^4 .* (V-V_K);
I_A = g_A * m_Ainf.^3 .* h_A .* (V-V_K);
I_KS = g_KS .* m_KS .* (V-V_K);
I_Ca = g_Ca .* m_Cainf.^2 .* (V - V_Ca);
I_KCa = g_KCa .* m_KCainf .* (V-V_K);
I_NaP = g_NaP * m_NaPinf.^3 .* (V-V_Na);
I_AR = g_AR .* h_ARinf .* (V-V_K);

I_AMPA = g_AMPA.*s_AMPA.*(V-V_AMPA);
I_NMDA = g_NMDA.*s_NMDA.*(V-V_NMDA);
I_GABA = g_GABA.*s_GABA.*(V-V_GABA);



I_syn=I_NMDA+I_GABA+I_AMPA;


    
% f_V=1./(1+exp(-(V-20)/2));

% fire_ind=find(V>0);
%fire_ind=[];
%f_V(old_fire_ind)=0;
%f_V=f_V.*(f_V>-3.0590e-07);

%f_V=(f_V'*(w+eye(N_neuron))./(n_conn+1))';

% f_V=(f_V'*w./n_up)';
% f_V(isnan(f_V)) = 0;


%w_i=sum_j(w_ji)/n_i, I also include the neuron itself in the average to
%prevent that if a neuron has no connection we don't divide by zero

dVdt = -(I_L+I_Na+I_K+I_A+I_KS+I_Ca+I_KCa+I_NaP+I_AR)/C...
    -I_syn/(10*C*A);%randn*0.05;

% if max(abs(dVdt))>1000 
%     pause
% end

dh_Nadt=4* (alpha_h.*(1-h_Na)-beta_h.*h_Na);
dn_Kdt = 4 * (alpha_n .* (1 - n_K) - beta_n .* n_K);
dh_Adt = (h_Ainf - h_A)./tau_hA;
dm_KSdt = (m_KSinf - m_KS)./tau_mKS;
dCadt = -alphaCa .* (10 * A * I_Ca+I_NMDA) -C_Ca./tau_Ca;
% if max(abs(dCadt))>100 
%     pause
% end
ds_AMPAdt=3.48*input_exc-s_AMPA./tau_AMPA;
ds_NMDAdt=0.5*x_NMDA.*(1-s_NMDA)-s_NMDA./tau_sNMDA;
dx_NMDAdt=3.48*input_exc-x_NMDA./tau_xNMDA;
ds_GABAdt=input_inh-s_GABA./tau_GABA;


vel = [dVdt dh_Nadt dn_Kdt dh_Adt dm_KSdt dCadt ...
    ds_AMPAdt ds_NMDAdt dx_NMDAdt ds_GABAdt];
if ~isreal(vel)
    pause;
end

% x_new=x+advvel*dt;
% h_Na_new = x_new(:,2);

% if min(h_Na_new)<0 || max(h_Na_new)>1
%     pause
% end

end