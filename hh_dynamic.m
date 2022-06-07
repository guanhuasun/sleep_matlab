function [vel] = hh_dynamic(x,I_app,input_exc,input_inh,sigma_noise)%,N_neuron,old_fire_ind,with_noise)

%SAN model without input
%   x:  dimension x = (V,m,h,n,C_Ca,s_AMPA, s_NMDA, x_NMDA, s_GABA)
%   t: time, not used.
%   Y: coupling strength

V = x(:,1);
m=x(:,2);
h = x(:,3);
n = x(:,4);
C_Ca = x(:,5);
s_AMPA = x(:,6);
s_NMDA = x(:,7);
x_NMDA = x(:,8);
s_GABA = x(:,9);

if min(h)<0 || min(n)<0
    pause
end

C = 1;
A = 0.02;
g_L = 0.3;v_L = -50;
g_Na = 120;V_Na = 55;
g_K = 36;V_K = -72;
g_Ca = 0;%0.0256867;
V_Ca = 120;

Ar=5;Ad=0.18;
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

alphaCa = 0.5;

tau_AMPA=4;
tau_sNMDA=100;
tau_xNMDA=2;
tau_GABA=10;
tau_Ca=121;

% m_inf = alpha_m./(alpha_m+beta_m);
% h_inf = alp ./ (1 + exp((V + 80) / 6));
% m_KSinf = 1 ./ (1 + exp( -(V + 34)/6.5) );
m_Cainf = 1 ./ (1 + exp(-(V + 20) / 9));

I_L= g_L .* (V-v_L);
I_Na = g_Na * m.^3 .* h .* (V-V_Na);
I_K = g_K * n.^4 .* (V-V_K);
I_Ca = g_Ca .* m_Cainf.^2 .* (V - V_Ca);

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

dVdt = -(I_L+I_Na+I_K+I_Ca-I_app+I_syn)/C;%randn*0.05;

% if max(abs(dVdt))>1000 
%     pause
% end

dmdt=alpha_m.*(1-m)-beta_m.*m;
dhdt=alpha_h.*(1-h)-beta_h.*h;
dndt=alpha_n.*(1-n)-beta_n.*n;

dCadt = -alphaCa .* (I_Ca+I_NMDA) - C_Ca ./ tau_Ca;
% if max(abs(dCadt))>100 
%     pause
% end
%ds_AMPAdt=Ar*input_exc-s_AMPA./tau_AMPA;
ds_AMPAdt = 3.48*input_exc-s_AMPA./tau_AMPA;
ds_NMDAdt=0.5*x_NMDA.*(1-s_NMDA)-s_NMDA./tau_sNMDA;
dx_NMDAdt=3.48*input_exc-x_NMDA./tau_xNMDA;
ds_GABAdt=input_inh-s_GABA./tau_GABA;


vel = [dVdt, dmdt, dhdt, dndt,dCadt, ds_AMPAdt, ds_NMDAdt, dx_NMDAdt, ds_GABAdt];

if ~isreal(vel)
    "something is not right"
    pause;
end

% x_new=x+advvel*dt;
% h_Na_new = x_new(:,2);

% if min(h_Na_new)<0 || max(h_Na_new)>1
%     pause
% end

end