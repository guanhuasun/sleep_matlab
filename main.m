clear
N_neuron=250; %number of neurons
% dt=0.08;
T=5000;
write_dt=4;

neuron_model=2; %1 for HH, 2 for AN


for lamda=[0.02]
% r_exc=5;
r_inh=0;
with_noise=0;    
for r_exc=[9]
    w_max=2;
    
    for theta_p=[23.4]
        w_min=0;
        for gamma_p=[400] 
%             theta_p=[23.6];
            for n_method=[1]
                theta_d=[23.1]
                for tau=20
                    for dt = [0.04,0.02,0.01]
                        
                    if neuron_model ==1
                        initialize_hh
                    elseif neuron_model==2
                        initialize_an
                    end
                    gamma_d=200;
                    sigma_noise=5;
                    initialize_output;
                    %dirname=("../"+sprintf('n%ue%ui%ulam%g',N_neuron,r_exc,r_inh,lamda));
                    dirname=("../hhtest");
                    simname='test'
                    foldername=fullfile(dirname,simname);
                    mkdir(foldername);
                    kaiguan=0;Vt=10;Kp=2;
                    % weights_exc=weights_exc*0.5;weights_inh=weights_inh*0.5;
                    I_app=10;
                    result=zeros(ceil(T/write_dt),N_neuron);
                        for t_sim=0:dt:T
                            v=x(:,1);
                            w_exc(wind_exc)=weights_exc; 
                            w_inh(wind_inh)=weights_inh;
                            input_exc=syn_input(w_exc,n_pre_exc,v,Vt,Kp);
                            input_inh=syn_input(w_inh,n_pre_inh,v,Vt,Kp);
                            if neuron_model==1
                                 x=x+dt*hh_dynamic(x,I_app,input_exc,input_inh,sigma_noise);
%                                 x=hh_leapfrog(x,I_app,input_exc,input_inh,dt,sigma_noise);
                                c_ca=x(:,5);
                            elseif neuron_model==2
                                an_update;
                                c_ca=x(:,6);
                            end
                              [cal_syn_exc,weights_exc]=cal_update(weights_exc,w_max,w_min,pre_exc,post_exc,c_ca,theta_p,theta_d,gamma_p,gamma_d,tau,dt,kaiguan);    
                              [cal_syn_inh,weights_inh]=cal_update(weights_inh,w_max,w_min,pre_inh,post_inh,c_ca,theta_p,theta_d,gamma_p,gamma_d,tau,dt,kaiguan); 
                            if t_sim>5000
                                kaiguan=0;
                            end
                             save_frame;
                        end
                            save_file;
                    end
                end
            end
        end
    end
end
end
