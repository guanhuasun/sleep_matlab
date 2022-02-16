%sim_plot
close all
spect_plot=0;
hist_plot=0;

t_vec=[write_dt:write_dt:T];
figure
cal_plot=plot(t_vec,cal_data(:,1:end),'LineWidth',1.5);
grid on
xlabel('Time/ms');
ylabel('[Ca] of Neurons');
set(gca,'FontSize',25)

figure
v_plot=plot(t_vec,v_data(:,1:end),'LineWidth',1.5);
grid on
xlabel('Time/ms');
ylabel('V of Neurons');
set(gca,'FontSize',25)

figure
v_fire=v_data'>0;
imagesc(v_fire)

figure
v_plot=plot(t_vec,w_data(:,1:end),'LineWidth',1.5);
grid on
xlabel('Time/ms');
ylabel('Synaptic Weights');
set(gca,'FontSize',25)

figure
v_plot=plot(t_vec,sum(v_data,2)/1000,'LineWidth',1.5);
grid on
xlabel('Time/ms');
ylabel('Average Voltage');
set(gca,'FontSize',25)

if spect_plot
    Fs = 1000/(write_dt);            % Sampling frequency                    
    P = 1/Fs;             % Sampling period       
    vs_data=v_avg(1:end/2,:);
    L = length(vs_data);    % Length of signal
    t_vec = (0:L-1)*P;        % Time vector

    Y = fft(vs_data);
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    f = Fs*(0:(L/2))/L;
    figure
    plot(f(2:end),P1(2:end),'LineWidth',1.5) 
    drawnow
end

if hist_plot
    for k = 1:100:99201
    histogram(w_data(k,:))
    drawnow
    end
end
