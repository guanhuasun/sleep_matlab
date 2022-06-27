clear
N_neuron=250; %number of neurons
% dt=0.08;
T=10000;
%write_dt=4;
neuron_model=2; %1 for HH, 2 for AN

for lamda=[0.02]
% r_exc=5;
r_inh=1;
with_noise=0;    
for r_exc=[9]
    w_max=2;
   
    for theta_p=[23.4]
        w_min=0;
        for gamma_p=[400] 
%             theta_p=[23.6];
            for n_method=[2]
%                 figure
                theta_d=[23.1];
                for tau=20
                    for w_s=[0.1:0.1:1]
                        dt = [0.02];
                        write_dt=1;
                    if neuron_model ==1
                        initialize_hh
                    elseif neuron_model==2
                        initialize_an
                        w_exc_ini=w_s;
                        w_inh_ini=w_exc_ini;
                        weights_exc= w_exc_ini*ones(n_conn_exc,1);
                        weights_inh=w_inh_ini*ones(n_conn_inh,1);
                    end
                    gamma_d=200;
                    sigma_noise=1;
                    initialize_output;
                    dirname=('../noise_test3_sigma1');
                    %simname='noise_test2';
                    %dirname=("../uniform_synaptic");
                    simname=sprintf('n%uw%gdt%grk4',N_neuron,w_s,dt)
                    foldername=fullfile(dirname,simname);
                    mkdir(foldername);
                    kaiguan=0;Vt=20;Kp=2; %-20, 3 for HH; 20,2 for AN
                    % weights_exc=weights_exc*0.5;weights_inh=weights_inh*0.5;
                    I_app=10;
                    %result=zeros(ceil(T/write_dt),10);
                        for t_sim=0:dt:T
                            v=x(:,1);
                            w_exc(wind_exc)=weights_exc; 
                            w_inh(wind_inh)=weights_inh;
                            input_exc=syn_input(w_exc,n_pre_exc,v,Vt,Kp);
                            input_inh=syn_input(w_inh,n_pre_inh,v,Vt,Kp);
                            if neuron_model==1
                                if n_method ==1
                                 x=x+dt*hh_dynamic(x,I_app,input_exc,input_inh,sigma_noise);
                                elseif n_method ==2
                                 x=hh_leapfrog(x,I_app,input_exc,input_inh,dt,sigma_noise);
                                end
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
                            %result(ind_save,:)=x;
                           % ind_save=ind_save+1;
                             save_frame;
                             
                        end
%                             hold on
%                             f_V=1./(1+exp(-(result(:,1)-Vt)/Kp));
%                             plot(0:write_dt:T,result(:,6));
%                             hold on
%                             plot(0:write_dt:T,result(:,1));
                            save_file;
                    end
                end
            end
        end
    end
end
end
