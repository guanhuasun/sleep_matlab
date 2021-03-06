k1=an_dynamic(x,g_NMDA,tau_Ca,input_exc,input_inh,sigma_noise,dt);
x_temp1=x+dt/2*k1;
v1=x_temp1(:,1);
input_exc=syn_input(w_exc,n_pre_exc,v1,Vt,Kp);
input_inh=syn_input(w_inh,n_pre_inh,v1,Vt,Kp);

k2=an_dynamic(x_temp1,g_NMDA,tau_Ca,input_exc,input_inh,sigma_noise,dt);
x_temp2=x+dt/2*k2;
v2=x_temp2(:,1);
input_exc=syn_input(w_exc,n_pre_exc,v2,Vt,Kp);
input_inh=syn_input(w_inh,n_pre_inh,v2,Vt,Kp);

k3=an_dynamic(x_temp2,g_NMDA,tau_Ca,input_exc,input_inh,sigma_noise,dt);
x_temp3=x+dt*k3;
v3=x_temp3(:,1);
input_exc=syn_input(w_exc,n_pre_exc,v3,Vt,Kp);
input_inh=syn_input(w_inh,n_pre_inh,v3,Vt,Kp);

k4=an_dynamic(x_temp3,g_NMDA,tau_Ca,input_exc,input_inh,sigma_noise,dt);





