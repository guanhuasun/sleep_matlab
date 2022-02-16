connection; %making connectivity matrix w


%all initial conditions are taken from Tatsuki et al,2016
v_ini=-20+30*(rand(N_neuron,1)-0.5);
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