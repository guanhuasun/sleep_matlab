%sim_plot
t_vec=[write_dt:write_dt:T];
figure
ca_plot=plot(t_vec,ca_result(:,1:50:end),'LineWidth',1.5);
grid on
xlabel('Time/ms');
ylabel('[Ca] of Neurons');
set(gca,'FontSize',25)

figure
v_plot=plot(t_vec,v_result(:,1:50:end),'LineWidth',1.5);
grid on
xlabel('Time/ms');
ylabel('V of Neurons');
set(gca,'FontSize',25)


figure
v_plot=plot(t_vec,w_result(:,1:50:end),'LineWidth',1.5);
grid on
xlabel('Time/ms');
ylabel('Synaptic Weights');
set(gca,'FontSize',25)

figure
v_plot=plot(t_vec,sum(v_result,2)/1000,'LineWidth',1.5);
grid on
xlabel('Time/ms');
ylabel('Average Voltage');
set(gca,'FontSize',25)



Fs = 1000/write_dt;            % Sampling frequency                    
P = 1/Fs;             % Sampling period       
vs_data=v_avg(1:end,:);
L = length(vs_data);    % Length of signal
t_vec = (0:L-1)*P;        % Time vector

Y = fft(vs_data);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
figure
plot(f(1:end),P1(1:end),'LineWidth',1.5) 
drawnow
