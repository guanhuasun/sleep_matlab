function [t_input]=syn_input(w,n_up,V)

    f_V=1./(1+exp(-(V-20)/2));    
    t_input=(f_V'*w./n_up)';
    t_input(isnan(t_input)) = 0;
end