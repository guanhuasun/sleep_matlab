clear
N_neuron=100; %number of neurons
dt=0.04;
T=5000;
g_NMDA=0.004;%0.004;%0.0038;
tau_Ca=121;
write_dt=4;

for lamda=[0.1]
% r_exc=5;
r_inh=1;
% lamda=0.01;

%w=eye(N_neuron);
%w=[0 1;1 0];
%x=rand(N_neuron,10).*x;
%x(:,1)=randn(N_neuron,1).*x(:,1);
num_t=1;
with_noise=0;
for r_exc=[8]
    w_max=2;
    for theta_p=[15]
        w_min=0;
        w_exc_ini=1.8;
        w_inh_ini=1.8;
        for gamma_p=[200] 
%             theta_p=[23.6];
            for theta_gap=[0.5]
                theta_d=theta_p-theta_gap;
                for tau=20
                    initialize
                    gamma_d=200;
                    sigma_noise=5;
                    result=zeros(ceil(T/write_dt),11);
                    w_list=zeros(ceil(T/write_dt),N_neuron);
                     weights_exc= w_exc_ini*ones(n_conn_exc,1);
                     weights_inh=w_inh_ini*ones(n_conn_inh,1);
%                     weights_exc=[1;3];
%                     weights_inh=[3;1];
                    
                    dirname='../n10';
                   %dirname=("../"+sprintf('e%ui%ulam%g',r_exc,r_inh,lamda));
                   % simname=sprintf('n%up%ud%ugp%ugd%utau%uw_max%gw_min%g',N_neuron,10*theta_p,10*theta_d,gamma_p,gamma_d,tau,w_max,w_min)
                      simname='test';
                    foldername=fullfile(dirname,simname);
                    %foldername=sprintf("n%ug%gtau_ca%uw%g",N_neuron,g_NMDA,tau_Ca,w_val);
                    mkdir(foldername);
                    fire_count=zeros(N_neuron,1);
                    kaiguan=0;
                     v=x(:,1);
                    % weights_exc=weights_exc*0.5;weights_inh=weights_inh*0.5;
                    w_exc_data=zeros(T/write_dt ,length(post_exc));
                    w_inh_data=zeros(T/write_dt,length(post_inh));
                    cal_syn_exc_data=zeros(T/write_dt,length(post_exc));
                    cal_syn_inh_data=zeros(T/write_dt,length(post_inh));
                    ind_save=1;
                        for t_sim=0:dt:T
                            w_exc(wind_exc)=weights_exc;
                            w_inh(wind_inh)=weights_inh;

                            input_exc=syn_input(w_exc,n_pre_exc,v);
                            input_inh=syn_input(w_inh,n_pre_inh,v);

                            [fire_ind,x]=an_dynamic(x,g_NMDA,tau_Ca,input_exc,input_inh,dt,sigma_noise);%N_neuron,fire_ind,with_noise);
%                             if mod(t_sim,1)==0
%                                 fire_count(fire_ind)=fire_count(fire_ind)+1;
%                             end
                            v=x(:,1);
                            c_ca=x(:,6);
                            h_Na = x(:,2);
                            [cal_syn_exc,weights_exc]=cal_update(weights_exc,w_max,w_min,pre_exc,post_exc,c_ca,theta_p,theta_d,gamma_p,gamma_d,tau,dt,kaiguan);    
                            [cal_syn_inh,weights_inh]=cal_update(weights_inh,w_max,w_min,pre_inh,post_inh,c_ca,theta_p,theta_d,gamma_p,gamma_d,tau,dt,kaiguan); 

                            if t_sim>5000
                                kaiguan=1;
                            end

                            if mod(t_sim,write_dt)==0
                                xname=sprintf('t%gx.mat',t_sim);xname=fullfile(foldername,xname);
                                w_exc_data(ind_save,:)=weights_exc';
                                w_inh_data(ind_save,:)=weights_inh';
                                cal_syn_exc_data(ind_save,:)=cal_syn_exc';
                                cal_syn_inh_data(ind_save,:)=cal_syn_inh';
                                
                                save(xname,'x');
                                num_t=num_t+1;
                               % t_sim
                               ind_save=ind_save+1;
                            end
                        end
                            w_excname='w_exc_data.mat';w_excname=fullfile(foldername,w_excname);
                            w_inhname='w_inh_data.mat';w_inhname=fullfile(foldername,w_inhname);
                            cal_excname='cal_exc_data.mat';cal_excname=fullfile(foldername,cal_excname);
                            cal_inhname='cal_inh_data.mat';cal_inhname=fullfile(foldername,cal_inhname);
                            save(w_excname,'w_exc_data');save(w_inhname,'w_inh_data');save(cal_excname,'cal_syn_exc_data');save(cal_inhname,'cal_syn_inh_data');

                end
            end
        end
    end
end
end

% plot(result(:,1),result(:,2),'LineWidth',2)
% grid on