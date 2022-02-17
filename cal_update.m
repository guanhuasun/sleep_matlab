function [cal_syn,w_new] = cal_update(w_old,w_max,w_min,up_ind,down_ind,cal_neuron,theta_p,theta_d,gamma_p,gamma_d,tau,dt,kaiguan)
     cal_syn=cal_neuron(up_ind)+cal_neuron(down_ind);
    if kaiguan
        p_syn=cal_syn>theta_p;
        d_syn=cal_syn>theta_d;
        dwdt=1e-3*dt*(gamma_p*(w_max-w_old).*p_syn-gamma_d*(w_old-w_min).*d_syn)/tau;
        w_new=w_old+dwdt;
    else
        w_new=w_old;
%         cal_syn=[];
    end

end