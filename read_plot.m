%read file
N_neuron=1000;
lamda=0.01;
n_conn=N_neuron^2*lamda;
T=5000;
write_dt=1;
num_frame=ceil(T/write_dt);
v_data=zeros(num_frame,N_neuron);
cal_syn_data=zeros(num_frame,n_conn);
cal_data=v_data;
w_data=zeros(num_frame,n_conn);

theta_p=23;
theta_d=theta_p-0.3; 
tau=100;
gamma_p=200;
gamma_d=200;
foldername=sprintf("n%up%ud%ugp%ugp%utau%u",N_neuron,10*theta_p,10*theta_d,gamma_p,gamma_d,tau);
% foldername="n1";
for ind_frame = 1:num_frame
    t_plot=ind_frame*write_dt;
    
    xname=sprintf('t%gx.mat',t_plot);xname=fullfile(foldername,xname);
    wname=sprintf('t%gw.mat',t_plot);wname=fullfile(foldername,wname);
    calname=sprintf('t%gcal.mat',t_plot);calname=fullfile(foldername,calname);
    load(xname);
    load(wname);
    load(calname);

    v=x(:,1);
    c_ca=x(:,6);
     
    v_data(ind_frame,:)=v';
    cal_data(ind_frame,:)=c_ca';
    w_data(ind_frame,:)=weights';
    cal_syn_data(ind_frame,:)=cal_syn;
    %histogram(weights)
    %xlim([0,1])
    %drawnow

end

v_avg=sum(v_data,2)/N_neuron;


    