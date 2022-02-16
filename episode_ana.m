close all

plot_dt=0.004; %in second
% v_avg=mean(v_data,2);
t_begin=1;
t_end=20;
t_check=[t_begin,t_end]; %enter all time we want to check the synaptic weight distribution
N_sample=250;
firsttime=1;
mean_window=1; %second
mean_window=mean_window/plot_dt; %indices 

if firsttime
    w_exc_stats=[mean(w_exc_data,2) median(w_exc_data,2) std(w_exc_data,[],2) ];
    w_inh_stats=[mean(w_inh_data,2) median(w_inh_data,2) std(w_inh_data,[],2) ];
    w_exc_stats_movmean=movmean(w_exc_stats,mean_window);
    w_exc_stats_5=prctile(w_exc_data,5,2);
    w_exc_stats_95=prctile(w_exc_data,95,2);
    w_inh_stats_5=prctile(w_inh_data,5,2);
    w_inh_stats_95=prctile(w_inh_data,95,2);
    cal_exc_stats=[mean(cal_syn_exc_data,2) median(cal_syn_exc_data,2) std(cal_syn_exc_data,[],2) ];
    cal_inh_stats=[mean(cal_syn_inh_data,2) median(cal_syn_inh_data,2) std(cal_syn_inh_data,[],2) ];
    cal_exc_stats_5=prctile(cal_syn_exc_data,5,2);
    cal_exc_stats_95=prctile(cal_syn_exc_data,95,2);
    cal_inh_stats_5=prctile(cal_syn_inh_data,5,2);
    cal_inh_stats_95=prctile(cal_syn_inh_data,95,2);
    cal_exc_stats_movmean=movmean(cal_exc_stats,mean_window);
    cal_inh_stats_movmean=movmean(cal_inh_stats,mean_window);
end


 
t_vec=t_begin:plot_dt:t_end;
ind_begin=t_begin/plot_dt;
ind_end=t_end/plot_dt;
p_line=theta_p*ones(length(t_vec),1);
d_line=theta_d*ones(length(t_vec),1);

figure
plot(t_vec,[w_exc_stats(ind_begin:ind_end,1) w_exc_stats_95(ind_begin:ind_end) w_exc_stats_5(ind_begin:ind_end)],'-','LineWidth',1.5)
hold on
plot(t_vec,[w_inh_stats(ind_begin:ind_end,1) w_inh_stats_95(ind_begin:ind_end) w_inh_stats_5(ind_begin:ind_end)],'-.','LineWidth',1.5)
xlim([t_begin t_end])


figure 
plot(t_vec,cal_syn_exc_data(ind_begin:ind_end,1:10:end));
hold on
plot(t_vec,cal_syn_inh_data(ind_begin:ind_end,1:10:end));
hold on
plot(t_vec,[p_line d_line])
xlim([t_begin t_end])


% for t_plot = t_check
%     ind_plot=t_plot/write_dt;
%     w_ind=w_data(ind_plot,:);
% %     figure
%     histogram(w_ind,10);
%     hold on
%     title_name=sprintf('t=%g',t_plot);
% %     title(title_name);
% %     pause(0.05)
%     drawnow
% end
% legend('Begin','End');
% xlabel('Time/s');
% set(gca,'FontSize',20)

figure
v_fire=v_data'>0;
imagesc(t_vec,1:N_sample,v_fire(:,ind_begin:ind_end))
xlabel('Time/s');
xlim([t_begin t_end])
% 
% figure
% fire_count=sum(v_fire(:,ind_begin:ind_end),2);
% fire_freq=fire_count/(t_end-t_begin+1);
% histogram(fire_freq,10)

% figure
% plot(t_vec_w,abs(w_stats_movmean(ind_begin:ind_end,4)),'LineWidth',2)
% grid on
% xlim([t_begin t_end])
% xlabel('Time/s');
% ylabel('W Skewness(Abs)')
% set(gca,'FontSize',20)
% 
% figure
% plot(t_vec_w,abs(w_exc_stats_movmean(ind_begin_w:ind_end_w,3)),'LineWidth',2)
% grid on
% xlim([t_begin t_end])
% xlabel('Time/s');
% ylabel('W Std')
% set(gca,'FontSize',20)


figure
plot(t_vec,v_data(ind_begin:ind_end,1:50:end),'LineWidth',1)
hold on
plot(t_vec,v_avg(ind_begin:ind_end),'LineWidth',2)
grid on
xlim([t_begin t_end])
xlabel('Time/s');
ylabel('Voltage')
set(gca,'FontSize',20)

% figure
% plot(t_vec,w_stats_5(ind_begin:ind_end,end),'LineWidth',2)
% hold on
% plot(t_vec,w_stats_movmean(ind_begin:ind_end,1),'LineWidth',2)
% hold on
% plot(t_vec,w_stats_95(ind_begin:ind_end,end),'LineWidth',2)
% grid on
% xlim([t_begin t_end])
% xlabel('Time/s');
% ylabel('W Average')
% legend('5%','Mean','95')
% set(gca,'FontSize',20)
% 
% figure
% plot(t_vec,v_avg(ind_begin:ind_end,1),'LineWidth',2)
% grid on
% xlim([t_begin t_end])
% xlabel('Time/s');
% ylabel('V Average')
% set(gca,'FontSize',20)


time_bin=1;
num_bin=(t_end-t_begin)/time_bin;
bin_size=time_bin/plot_dt;
vs_data=v_avg(ind_begin:ind_end-1,:);
% bin_size=length(vs_data)/num_bin;
spectrum_result=zeros(bin_size/2,num_bin);
for k = 1:num_bin
    bin_data=vs_data((k-1)*bin_size+1:k*bin_size);
    [f_result,p_result]=spectrum_ana(write_dt,bin_size,bin_data);
    spectrum_result(:,k)=p_result;
end
f_up=64;
f_ind=find(f_result==f_up);
s_plot=spectrum_result(1:f_up,:);

figure
imagesc(t_vec,1:f_up,s_plot)
colorbar
pmax=max(max(s_plot));pmin=min(min(s_plot));
plevel=20;pstep=(pmax-pmin)/20;
caxis([pmin pmax-5*pstep])
xlabel('Time/s')
ylabel('Frequency/Hz')
set(gca,'FontSize',25)
% w_std_plot=w_stats_movmean(ind_begin:250:ind_end-1,3);


