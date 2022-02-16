write_dt=0.001; %in second
T=2;
Fs = 1/write_dt;            % Sampling frequency                    
P = 1/Fs;             % Sampling period       
L = length(vs_data);    % Length of signal
t_vec = (0:L-1)*P;        % Time vector

num_bin=20;
bin_size=L/num_bin;
vs_data=v_avg(1:end,:);
f = Fs*(0:(bin_size/2))/bin_size;
spectrum_result=zeros(bin_size/2,num_bin);
for k = 1:num_bin
    bin_data=vs_data((k-1)*bin_size+1:k*bin_size);
    bin_hat=fft(bin_data)/bin_size;
    P2=abs(bin_hat);
    P1 = P2(1:bin_size/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    spectrum_result(:,k)=P1(2:end)';
end
    
% Y = fft(vs_data);
% P2 = abs(Y/L);
% P1 = P2(1:L/2+1);
% P1(2:end-1) = 2*P1(2:end-1);
% f = Fs*(0:(L/2))/L;
% figure
% plot(f(1:end),P1(1:end),'LineWidth',1.5) 
% drawnow