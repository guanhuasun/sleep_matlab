%making connectivity matrix w
n_exc=ceil(N_neuron*(r_exc/(r_exc+r_inh)));exc_ind=[1:n_exc];
n_inh=N_neuron-n_exc;inh_ind=[n_exc+1:N_neuron];
[w_exc,offset_exc, indices_exc,pre_exc,post_exc,wind_exc]=connection(lamda,N_neuron,exc_ind,[1:N_neuron]);
[w_inh,offset_inh, indices_inh,pre_inh,post_inh,wind_inh]=connection(lamda,N_neuron,inh_ind,[1:N_neuron]);

%self-excitatory, self-inhibitory and in between
% w_exc=[1 1;0 0];offset_exc=[0 1 2];indices_exc=[1 2];pre_exc=[1 1];post_exc=[1 2];wind_exc=find(w_exc==1);
% w_inh=[0 0 ;1 1];offset_inh=[0 1 2];indices_inh=[1 2];pre_inh=[2 2];post_inh=[1 2];wind_inh=find(w_inh==1);

% %no in between excitatory
% w_exc=[1 0;0 0];offset_exc=[0 1];indices_exc=[1];pre_exc=[1];post_exc=[1];wind_exc=find(w_exc==1);
% w_inh=[0 0 ;1 1];offset_inh=[0 1 2;];indices_inh=[1 2];pre_inh=[2 2];post_inh=[1 2];wind_inh=find(w_inh==1);

%no self-excitatory
% w_exc=[0 1;0 0];offset_exc=[0 1];indices_exc=[2];pre_exc=[1];post_exc=[2];wind_exc=find(w_exc==1);
% w_inh=[0 0 ;1 1];offset_inh=[0 1 2];indices_inh=[1 2];pre_inh=[2 2];post_inh=[1 2];wind_inh=find(w_inh==1);

%no in between inhibitory
% w_exc=[1 1;0 0];offset_exc=[0 1 2];indices_exc=[1 2];pre_exc=[1 1];post_exc=[1 2];wind_exc=find(w_exc==1);
% w_inh=[0 0 ;0 1];offset_inh=[0 1];indices_inh=[2];pre_inh=[2];post_inh=[2];wind_inh=find(w_inh==1);

%no self-inh
% w_exc=[1 1;0 0];offset_exc=[0 1 2];indices_exc=[1 2];pre_exc=[1 2];post_exc=[1 2];wind_exc=find(w_exc==1);
% w_inh=[0 0 ;1 0];offset_inh=[0 1];indices_inh=[1];pre_inh=[1 2];post_inh=[1 2];wind_inh=find(w_inh==1);

n_pre_exc=sum(w_exc,1);
n_post_exc=sum(w_exc,2);
n_conn_exc=sum(n_pre_exc);

n_pre_inh=sum(w_inh,1);
n_post_inh=sum(w_inh,2);
n_conn_inh=sum(n_pre_inh);


%all initial conditions are taken from Tatsuki et al,2016
v_ini=-20+60*(rand(N_neuron,1)-0.5);
h_Na_ini=0.045*ones(N_neuron,1);
n_K_ini=0.54*ones(N_neuron,1);
h_A_ini=0.045*ones(N_neuron,1);
m_KS_ini=0.34*ones(N_neuron,1);
C_Ca_ini=1+9*rand(N_neuron,1);


s_AMPA_ini=zeros(N_neuron,1);
s_NMDA_ini=zeros(N_neuron,1);
x_NMDA_ini=zeros(N_neuron,1);
s_GABA_ini=zeros(N_neuron,1);

x=[v_ini h_Na_ini n_K_ini h_A_ini m_KS_ini C_Ca_ini s_AMPA_ini ...
    s_NMDA_ini x_NMDA_ini s_GABA_ini];