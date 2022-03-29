function [x_new] = exp_euler_update(x_old,g_NMDA,tau_Ca,input_exc,input_inh,dt)

%SAN model without input
%   x:  dimension x = (V,h_Na,n_K,h_A,m_Ks,C_Ca,s_AMPA, s_NMDA, x_NMDA, s_GABA)
%   t: time, not used.
%   Y: coupling strength
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

[a_V,a_h_Na,a_n_K,a_h_A,a_m_KS,a_Ca,a_s_AMPA, a_s_NMDA, a_x_NMDA,a_s_GABA,...
   b_V,b_h_Na,b_n_K,b_h_A,b_m_KS,b_Ca,b_s_AMPA, b_s_NMDA, b_x_NMDA,b_s_GABA ] =exp_ab(x_old,g_NMDA,tau_Ca,input_exc,input_inh);

a_x = [a_V a_h_Na a_n_K  a_m_KS  a_s_NMDA];
b_x = [b_V b_h_Na b_n_K  b_m_KS  b_s_NMDA];

a_xx=[a_h_A a_Ca a_s_AMPA  a_x_NMDA a_s_GABA];
b_xx=[b_h_A b_Ca b_s_AMPA b_x_NMDA b_s_GABA];

x_new_temp=exp_solve([V h_Na n_K m_KS s_NMDA],a_x,b_x,dt);

V=x_new_temp(:,1); h_Na=x_new_temp(:,2);n_K=x_new_temp(:,3);m_KS=x_new_temp(:,4);s_NMDA=x_new_temp(:,5);

xx_new=exp_solve([h_A C_Ca s_AMPA x_NMDA s_GABA],a_xx,b_xx,dt);
h_A=xx_new(:,1);C_Ca=xx_new(:,2);s_AMPA=xx_new(:,3);x_NMDA=xx_new(:,4);s_GABA=xx_new(:,5);

if ~isreal(a_x)
    pause;
end
%x:  dimension x = (V,h_Na,n_K,h_A,m_Ks,C_Ca,s_AMPA, s_NMDA, x_NMDA, s_GABA)
x_new=[V,h_Na,n_K,h_A,m_KS,C_Ca,s_AMPA, s_NMDA, x_NMDA, s_GABA];


end