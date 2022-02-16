function [cal_syn,w_new] = cal_update(w_old,n_conn,up_ind,down_ind,cal_neuron,theta_p,theta_d,gamma_p,gamma_d,tau,dt)
%    cal_syn=zeros(n_conn,1); %matrix of calcium on each synapse
%     w_mat=w_old;
    
%     for up_ind = 1:N_neuron
%         %for k=1:length(w_ind(up_i,:))
%         down_ind=indices(up_ind,:);
%         cal_syn(up_ind,:)=(cal_neuron(up_ind)+cal_neuron(down_ind))';
%     end
    cal_syn=cal_neuron(up_ind)+cal_neuron(down_ind);
    p_syn=cal_syn>theta_p;
    d_syn=cal_syn>theta_d;
    dwdt=1e-3*dt*(gamma_p*(1-w_old).*p_syn-gamma_d*w_old.*d_syn)/tau;
    w_new=w_old+dwdt;
    %w_mat(conn_wind)=w_list(1:end);
end