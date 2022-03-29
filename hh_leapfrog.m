function [x_new] = hh_leapfrog(x_old,I_app,input_exc,input_inh,dt,sigma_noise)%,N_neuron,old_fire_ind,with_noise)

%SAN model without input
%   x:  dimension x = (V,m,h,n,C_Ca,s_AMPA, s_NMDA, x_NMDA, s_GABA)
%   t: time, not used.
%   Y: coupling strength

V = x_old(:,1);
m=x_old(:,2);
h = x_old(:,3);
n = x_old(:,4);
C_Ca = x_old(:,5);
s_AMPA = x_old(:,6);
s_NMDA = x_old(:,7);
x_NMDA = x_old(:,8);
s_GABA = x_old(:,9);

if min(h)<0 || min(n)<0
    pause
end

C = 1;
A = 0.02;
g_L = 0.3;V_L = -50;
g_Na = 120;V_Na = 55;
g_K = 36;V_K = -72;
g_Ca = 0;%0.0256867;
V_Ca = 120;

Ar=5;Ad=0.18; %those from Dewoskin SCN paper
% I_app=0;

g_AMPA = 0;V_AMPA=0;
g_GABA = 0;V_GABA=-70;
g_NMDA=0;V_NMDA=0;

alpha_m = 0.1*(35 + V) ./ (1 - exp(-(35+V)/10));
if V == -35
    alpha_m = 1;
end
alpha_n = 0.01*(50 + V) ./ (1-exp(-(50 + V)/10));
if V == -50
    alpha_n = 0.1;
end
alpha_h = 0.07 * exp (-(V+60) / 20);

beta_m = 4 * exp(-(V + 60) / 18);
beta_n = 0.125 * exp(-(V + 60) / 80);
beta_h = 1 ./ (1 + exp(-(V+30) / 10));

% alphaCa = 0.5;
% 
% tau_AMPA=2;
% tau_sNMDA=100;
% tau_xNMDA=2;
% tau_GABA=10;
%  tau_Ca=121;

% m_inf = alpha_m./(alpha_m+beta_m);
% h_inf = alp ./ (1 + exp((V + 80) / 6));
% m_KSinf = 1 ./ (1 + exp( -(V + 34)/6.5) );
% m_Cainf = 1 ./ (1 + exp(-(V + 20) / 9));

% I_L= g_L .* (V-v_L);
% I_Na = g_Na * m.^3 .* h .* (V-V_Na);
% I_K = g_K * n.^4 .* (V-V_K);
% I_Ca = g_Ca .* m_Cainf.^2 .* (V - V_Ca);

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
% 
% dVdt = -(I_L+I_Na+I_K+I_Ca-I_app+I_syn)/C;%randn*0.05;

% if max(abs(dVdt))>1000 
%     pause
% end

% dmdt=alpha_m.*(1-m)-beta_m.*m;
% dhdt=alpha_h.*(1-h)-beta_h.*h;
% dndt=alpha_n.*(1-n)-beta_n.*n;
% 
% dCadt = -alphaCa .* (10 * A * I_Ca+I_NMDA) - C_Ca ./ tau_Ca;
% if max(abs(dCadt))>100 
%     pause
% end
% ds_AMPAdt=3.48*input_exc-s_AMPA./tau_AMPA;
% ds_NMDAdt=0.5*x_NMDA.*(1-s_NMDA)-s_NMDA./tau_sNMDA;
% dx_NMDAdt=3.48*input_exc-x_NMDA./tau_xNMDA;
% ds_GABAdt=input_inh-s_GABA./tau_GABA;

m_new=(alpha_m * dt + (1 - dt / 2 * (alpha_m + beta_m)) * m) / (dt / 2 * (alpha_m + beta_m) + 1);
h_new=(alpha_h * dt + (1 - dt / 2 * (alpha_h + beta_h)) * h) / (dt / 2 * (alpha_h + beta_h) + 1);
n_new=(alpha_n * dt + (1 - dt / 2 * (alpha_n + beta_n)) * n) / (dt / 2 * (alpha_n + beta_n) + 1);

G = g_Na * m_new.^3.*h_new + g_K * n_new^4+g_L;
E = g_Na * m_new.^3.*h_new * V_Na + g_K * n_new^4*V_K+g_L*V_L;

V_new=((sigma_noise + I_app) * dt + E * dt + (1 - dt / 2 * G)*V) / (1 + dt / 2 * G);

x_new=[V_new,m_new,h_new,n_new,C_Ca,s_AMPA, s_NMDA, x_NMDA, s_GABA];

if ~isreal(x_new)
    "something is not right"
    pause;
end

% x_new=x+advvel*dt;
% h_Na_new = x_new(:,2);

% if min(h_Na_new)<0 || max(h_Na_new)>1
%     pause
% end

end