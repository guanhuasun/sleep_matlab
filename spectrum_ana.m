function [f,p]=spectrum_ana(sample_dt,L_sample,v_data)
    % T=600;
    Fs = 1/sample_dt;            % Sampling frequency                    
    P = 1/Fs;             % Sampling period       
    f = Fs*(0:(L_sample/2))/L_sample;
    f=f(2:end);
    vhat=fft(v_data)/L_sample;
    P2=abs(vhat);
    P1 = P2(1:L_sample/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    p=P1(2:end)';
end

% set(gca,'YtickLabel',40:-2:1)
% Y = fft(vs_data);
% P2 = abs(Y/L);
% P1 = P2(1:L/2+1);
% P1(2:end-1) = 2*P1(2:end-1);
% f = Fs*(0:(L/2))/L;
% figure
% plot(f(1:end),P1(1:end),'LineWidth',1.5) 
% drawnow