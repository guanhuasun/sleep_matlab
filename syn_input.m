function [t_input]=syn_input(w,n_up,V,Vt,Kp)

    f_V=1./(1+exp(-(V-Vt)/Kp));    
%       f_V=f_V.*(f_V>0.1);
    t_input=(f_V'*w./n_up)';
    t_input(isnan(t_input)) = 0;
end