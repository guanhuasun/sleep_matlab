if mod(t_sim,write_dt)==0
    xname=sprintf('t%gx.mat',t_sim);xname=fullfile(foldername,xname);
    w_exc_data(ind_save,:)=weights_exc';
    w_inh_data(ind_save,:)=weights_inh';
    cal_syn_exc_data(ind_save,:)=cal_syn_exc';
    cal_syn_inh_data(ind_save,:)=cal_syn_inh';
    syn_input_data(2*(ind_save-1)+1:2*ind_save,:)=[input_exc';input_inh'];
    save(xname,'x');
   ind_save=ind_save+1;
end