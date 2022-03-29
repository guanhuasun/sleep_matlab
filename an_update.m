if n_method==1
     [vel]=an_dynamic(x,g_NMDA,tau_Ca,input_exc,input_inh,sigma_noise);%N_neuron,fire_ind,with_noise);
     x=x+dt*vel; %Forward Euler
elseif n_method==2
    rk4_an;
    x=x+1/6*dt*(k1+2*k2+2*k3+k4);
else
    xx=exp_euler_update(x,g_NMDA,tau_Ca,input_exc,input_inh,dt/2); %half step
    vv=xx(:,1); %voltage on half step
    input_exc=syn_input(w_exc,n_pre_exc,vv);
    input_inh=syn_input(w_inh,n_pre_inh,vv);
    x=exp_mid_update(x,xx,g_NMDA,tau_Ca,input_exc,input_inh,dt);
end