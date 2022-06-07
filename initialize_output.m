dirname='../convtest2';

if n_method==1
    simname=sprintf('n%up%ud%ugp%ugd%utau%uw_max%gw_min%gdt%geuler',N_neuron,10*theta_p,10*theta_d,gamma_p,gamma_d,tau,w_max,w_min,dt);
elseif n_method==2
    simname=sprintf('n%up%ud%ugp%ugd%utau%uw_max%gw_min%gdt%grk4',N_neuron,10*theta_p,10*theta_d,gamma_p,gamma_d,tau,w_max,w_min,dt);
else
    simname=sprintf('n%up%ud%ugp%ugd%utau%uw_max%gw_min%gdt%gexp',N_neuron,10*theta_p,10*theta_d,gamma_p,gamma_d,tau,w_max,w_min,dt);
end

w_exc_data=zeros(T/write_dt ,length(post_exc));
w_inh_data=zeros(T/write_dt,length(post_inh));
cal_syn_exc_data=zeros(T/write_dt,length(post_exc));
syn_input_data=zeros(2*T/write_dt,N_neuron);
cal_syn_inh_data=zeros(T/write_dt,length(post_inh));

ind_save=1;