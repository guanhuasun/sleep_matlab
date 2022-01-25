%read file
N_neuron=1000;
T=2000;
write_dt=1;
num_frame=ceil(T/write_dt);
v_result=zeros(num_frame,N_neuron);
cal_syn_result=zeros(num_frame,n_conn);
ca_result=v_result;
w_result=zeros(num_frame,n_conn);
foldername="test_wake_w03/";
for ind_frame = 1:num_frame
    t_plot=ind_frame*write_dt;
    
    xname=sprintf(foldername+'t%gx.mat',t_plot);
    wname=sprintf(foldername+'t%gw.mat',t_plot);
    calname=sprintf(foldername+'t%gcal.mat',t_plot);
    load(xname);
    load(wname);
    load(calname);

    v=x(:,1);
    c_ca=x(:,6);
     
    v_result(ind_frame,:)=v';
    ca_result(ind_frame,:)=c_ca';
    w_result(ind_frame,:)=weights';
    cal_syn_result(ind_frame,:)=cal_syn;
    %histogram(weights)
    %xlim([0,1])
    %drawnow

end

v_avg=sum(v_result,2)/N_neuron;


    