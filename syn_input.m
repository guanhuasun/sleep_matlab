function [t_input]=syn_input(w,n_up,V,Vt,Kp)
    
    f_V=1./(1+exp(-(V-Vt)/Kp));    
%       f_V=f_V.*(f_V>0.1);
%     t_input =zeros(N,1);
%     syn_idx_low=1;
%     for i = 1:N
%         n_conn=n_post(i);
%         syn_idx_up=syn_idx_low+n_conn-1;
%         idx_post=post_indices(syn_idx_low:syn_idx_up);
%         t_input(idx_post)=t_input(idx_post)+f_V(i)*weights(syn_idx_low:syn_idx_up);
%     end
    t_input=(f_V'*w./n_up)';
    t_input(isnan(t_input)) = 0;
end