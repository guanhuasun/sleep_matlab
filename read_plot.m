%read file
clear
N_neuron=250;
lamda=1;
for r_exc=[9]
% lamda_exc=0.02*l_k;
% lamda_inh=0.004*l_k;
r_inh=1;
% n_conn_exc=N_neuron^2*lamda_exc;n_conn_inh=N_neuron^2*lamda_inh;
T=10000;
write_dt=1;
num_frame=ceil(T/write_dt);
v_data=zeros(num_frame,N_neuron);
g_NMDA=0.004;%0.0038;
tau_Ca=121;
cal_data=v_data;h_Na_data=v_data;n_K_data=v_data;
h_A_data=v_data;m_KS_data=v_data;s_AMPA_data = v_data;
s_NMDA_data = v_data;x_NMDA_data = v_data;s_GABA_data = v_data;
% w_max=1.3;
% w_min=0;
%dt=0.04;
for theta_p=[23.4]
%     gamma_p=[200]
    for theta_gap=0.3
     theta_d=23.1; 
    tau=20;
%     gamma_p=300;
    gamma_d=200;
    n_method=3;
    for w_s=[0.1:0.1:1] 
        dt=[0.02]
        gamma_p=[400] 
        w_min=[0];
        w_max=2;
        
      %dirname=("../"+sprintf('e%gi%g',lamda_exc,lamda_inh));
%      dname=sprintf("e%ui%ulam%g",r_exc,r_inh,lamda);
   % dname=sprintf('noise1_n%uw%gdt%grk4',N_neuron,w_s,dt)
   dname='noise_test1';
     %dname=sprintf("n%ue%ui%ulam%g",N_neuron,r_exc,r_inh,lamda);
%      dirname=("../"+sprintf('e%ui%ulam%g',r_exc,r_inh,lamda));
    % dirname=("../"+sprintf('n%ue%ui%ulam%g',N_neuron,r_exc,r_inh,lamda));
     
    if n_method==1
        simname=sprintf('n%up%ud%ugp%ugd%utau%uw_max%gw_min%gdt%geuler',N_neuron,10*theta_p,10*theta_d,gamma_p,gamma_d,tau,w_max,w_min,dt)
    elseif n_method==2
        simname=sprintf('n%up%ud%ugp%ugd%utau%uw_max%gw_min%gdt%grk4',N_neuron,10*theta_p,10*theta_d,gamma_p,gamma_d,tau,w_max,w_min,dt)
    else
        simname=sprintf('n%up%ud%ugp%ugd%utau%uw_max%gw_min%gdt%gexp',N_neuron,10*theta_p,10*theta_d,gamma_p,gamma_d,tau,w_max,w_min,dt)
    end
    %simname=sprintf('n%up%ud%ugp%ugd%utau%uw_max%gw_min%g',N_neuron,10*theta_p,10*theta_d,gamma_p,gamma_d,tau,w_max,w_min)
   
    dirname=('../noise_test3_sigma1');
    %simname='noise_test2';
    simname=sprintf('n%uw%gdt%grk4',N_neuron,w_s,dt);
    foldername=fullfile(dirname,simname);
    % foldername=sprintf('n%up%ud%ugp%ugp%utau%uw_max%gw_min%g',N_neuron,10*theta_p,10*theta_d,gamma_p,gamma_d,tau,w_max,w_min);
    %foldername=sprintf('n%up%ud%ugp%ugp%utau%u',N_neuron,10*theta_p,10*theta_d,gamma_p,gamma_d,tau);
     %foldername=sprintf("n%ug%gtau_ca%uw%g",N_neuron,g_NMDA,tau_Ca,w_val);
    %foldername="test";
    w_excname='w_exc_data.mat';w_excname=fullfile(foldername,w_excname);
    w_inhname='w_inh_data.mat';w_inhname=fullfile(foldername,w_inhname);
    cal_excname='cal_exc_data.mat';cal_excname=fullfile(foldername,cal_excname);
    cal_inhname='cal_inh_data.mat';cal_inhname=fullfile(foldername,cal_inhname);
      exc_conn_name='w_exc_conn.mat';exc_conn_name=fullfile(foldername,exc_conn_name);
        inh_conn_name='w_inh_conn.mat';inh_conn_name=fullfile(foldername,inh_conn_name);
    syn_input_name='syn_input_data.mat';syn_input_name=fullfile(foldername,syn_input_name);
    load(w_excname); load(w_inhname);load(cal_excname);load(cal_inhname);
    load(syn_input_name);
   exc_input_data=syn_input_data(1:2:end,:);
   inh_input_data=syn_input_data(2:2:end,:);
        for ind_frame = 1:num_frame
            t_plot=(ind_frame-1)*write_dt;

            xname=sprintf('t%gx.mat',t_plot);xname=fullfile(foldername,xname);
    %         w_excname=sprintf('t%gw_exc.mat',t_plot);w_excname=fullfile(foldername,w_excname);
    %         w_inhname=sprintf('t%gw_inh.mat',t_plot);w_inhname=fullfile(foldername,w_inhname);
    %         cal_excname=sprintf('t%gcal_exc.mat',t_plot);cal_excname=fullfile(foldername,cal_excname);
    %         cal_inhname=sprintf('t%gcal_inh.mat',t_plot);cal_inhname=fullfile(foldername,cal_inhname);
            load(xname); 
    %         if ind_frame==1
    %             v_data=zeros(num_frame,N_neuron);
    %             cal_syn_exc_data=zeros(num_frame,length(cal_syn_exc));cal_syn_inh_data=zeros(num_frame,length(cal_syn_inh));
    %             w_exc_data=zeros(num_frame,length(cal_syn_exc));w_inh_data=zeros(num_frame,length(cal_syn_inh));
    %         end
            v=x(:,1);
            h_Na = x(:,2);
            n_K = x(:,3);
            h_A = x(:,4);
            m_KS = x(:,5);
            C_Ca = x(:,6);
            s_AMPA = x(:,7);
            s_NMDA = x(:,8);
            x_NMDA = x(:,9);
            s_GABA = x(:,10);

            v_data(ind_frame,:)=v';
            h_Na_data(ind_frame,:)=h_Na';
            n_K_data(ind_frame,:)=n_K';
            h_A_data(ind_frame,:)=h_A';
            m_KS_data(ind_frame,:)=m_KS';
            cal_data(ind_frame,:)=C_Ca';
            s_AMPA_data(ind_frame,:)=s_AMPA';
            s_NMDA_data(ind_frame,:)=s_NMDA';
            x_NMDA_data(ind_frame,:)=x_NMDA';
            s_GABA_data(ind_frame,:)=s_GABA';

    %         cal_syn_exc_data(ind_frame,:)=cal_syn_exc';cal_syn_inh_data(ind_frame,:)=cal_syn_inh';
    %         w_exc_data(ind_frame,:)=weights_exc';
    %         w_inh_data(ind_frame,:)=weights_inh';
        %     cal_syn_data(ind_frame,:)=cal_syn;
            %histogram(weights)
            %xlim([0,1])
            %drawnow

        end
        v_avg=sum(v_data,2)/N_neuron;
        figure_name=simname+"3.fig";
        episode_ana;
        end

    end
end
end



    