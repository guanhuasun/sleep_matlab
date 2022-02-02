clear
N_neuron=1; %number of neurons
connection; %making connectivity matrix w
n_up=sum(w,1);
n_down=sum(w,2);
n_conn=sum(n_up);

dt=0.04;
T=1000;
g_NMDA=0.0038;%0.0038;
tau_Ca=121;
write_dt=1;

%w=eye(N_neuron);
%w=[0 1;1 0];
%x=rand(N_neuron,10).*x;
%x(:,1)=randn(N_neuron,1).*x(:,1);
num_t=1;
with_noise=0;
w_max=2;

for theta_p=22
theta_d=theta_p-0.3; 
    for tau=100
initialize
gamma_p=200;
gamma_d=200;
sigma_noise=5;
result=zeros(ceil(T/write_dt),11);
w_list=zeros(ceil(T/write_dt),N_neuron);
fire_ind=[];
foldername='n1';
%foldername=sprintf('n%up%ud%ugp%ugp%utau%u',N_neuron,10*theta_p,10*theta_d,gamma_p,gamma_d,tau);
mkdir(foldername);
fire_count=zeros(N_neuron,1);
kaiguan=0;
w_target=lognrnd(-0.69,0.4,n_conn,1);
% weights=weights*0.5;
    for t_sim=0:dt:T
        w(conn_wind)=weights;
        [fire_ind,x]=an_dynamic(x,g_NMDA,tau_Ca,w,n_up,dt,N_neuron,sigma_noise);%N_neuron,fire_ind,with_noise);
        if mod(t_sim,1)==0
            fire_count(fire_ind)=fire_count(fire_ind)+1;
        end
        v=x(:,1);
        c_ca=x(:,6);
        h_Na = x(:,2);
        [cal_syn,weights]=cal_update(weights,w_max,up_ind,down_ind,c_ca,theta_p,theta_d,gamma_p,gamma_d,tau,dt,kaiguan);    

        if t_sim>1000
            kaiguan=1;
        end

        if mod(t_sim,write_dt)==0
            %result(num_t,:)=[t_sim sum(x)/N_neuron];
            xname=sprintf('t%gx.mat',t_sim);xname=fullfile(foldername,xname);
            wname=sprintf('t%gw.mat',t_sim);wname=fullfile(foldername,wname);
            calname=sprintf('t%gcal.mat',t_sim);calname=fullfile(foldername,calname);

            save(xname,'x');save(wname,'weights');save(calname,'cal_syn')


            %w_list(num_t,:)=(sum(w,2)./n_down)';
            num_t=num_t+1;
            t_sim
        end
    %     fire_name=sprintf(foldername+'fire_count.mat',fire_count);
    %     save(fire_name,'fire_count');
    end
    end
end

% plot(result(:,1),result(:,2),'LineWidth',2)
% grid on