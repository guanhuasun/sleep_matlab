 %close all
%r_exc=9;
r_inh=1;
plot_dt=write_dt/1000; %in second
% v_avg=mean(v_data,2);
t_begin=0;
t_end=T/1000;
t_check=[t_begin,t_end]; %enter all time we want to check the synaptic weight distribution
N_sample=250;
N_exc=ceil(r_exc/(r_exc+r_inh)*N_sample);
N_inh=N_sample-N_exc;
firsttime=1;
mean_window=5; %second
mean_window=mean_window/plot_dt; %indices 
fig_ind=1;
w_plot=0; w_stats_plot=0;cal_plot=1;s_plot=0;cal_stats_plot=0;raster_plot=0;v_plot=1;spec_plot=1;fire_rate_plot=0;sync_plot=0;
if firsttime
    w_exc_stats=[mean(w_exc_data,2) median(w_exc_data,2) std(w_exc_data,[],2) ];
    w_inh_stats=[mean(w_inh_data,2) median(w_inh_data,2) std(w_inh_data,[],2) ];
    w_exc_stats_movmean=movmean(w_exc_stats,mean_window);
    w_inh_stats_movmean=movmean(w_inh_stats,mean_window);
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


t_vec=t_begin:plot_dt:t_end-plot_dt;
ind_begin=t_begin/plot_dt+1;
ind_end=t_end/plot_dt;
p_line=theta_p*ones(length(t_vec),1);
d_line=theta_d*ones(length(t_vec),1);

if w_plot==1
    h(fig_ind)=figure;
    plot(t_vec,[w_exc_stats(ind_begin:ind_end,1) w_exc_stats_95(ind_begin:ind_end) w_exc_stats_5(ind_begin:ind_end)],'-','LineWidth',1.5)
    hold on
    plot(t_vec,[w_inh_stats(ind_begin:ind_end,1) w_inh_stats_95(ind_begin:ind_end) w_inh_stats_5(ind_begin:ind_end)],'-.','LineWidth',1.5)
    xlim([t_begin t_end])
    grid on
    title(simname)
    fig_ind=fig_ind+1;
end

if w_stats_plot==1
    h(fig_ind)=figure;
    plot(t_vec,abs(w_exc_stats_movmean(ind_begin:ind_end,3)./w_exc_stats_movmean(ind_begin:ind_end,1)),'LineWidth',2)
    hold on
    plot(t_vec,abs(w_inh_stats_movmean(ind_begin:ind_end,3)./w_inh_stats_movmean(ind_begin:ind_end,1)),'-.','LineWidth',2)
    grid on
     title(simname)
    xlim([t_begin t_end])
    xlabel('Time/s');
    ylabel('W Std')
    set(gca,'FontSize',25)
    legend('\sigma_{exc}','\sigma_{inh}');
    fig_ind=fig_ind+1;
end

if cal_plot==1
    h(fig_ind)=figure;
    plot(t_vec,cal_syn_exc_data(ind_begin:ind_end,1:50:end));
    hold on
    plot(t_vec,cal_syn_inh_data(ind_begin:ind_end,1:5:end),'-.');
    hold on
    plot(t_vec,[p_line d_line])
    xlim([t_begin t_end])
    ylim([theta_d-10 theta_p+2])
    grid on
     title(simname)
    fig_ind=fig_ind+1;
        xlabel('Time/s');
        set(gca,'FontSize',25)
    xlim([t_begin t_end])
end

if s_plot==1
    h(fig_ind)=figure;
     plot(t_vec,s_AMPA_data(ind_begin:ind_end,:));
%      hold on
%     plot(t_vec,s_GABA_data(ind_begin:ind_end,1:10:end));
%     hold on
%     plot(t_vec,s_NMDA_data(ind_begin:ind_end,1:10:end));
    
    xlim([t_begin t_end])
    grid on
     title(simname)
    fig_ind=fig_ind+1;
    xlabel('Time/s');
    xlim([t_begin t_end])
    fig_ind=fig_ind+1;
end

n_syn_exc=size(cal_syn_exc_data,2);
n_syn_inh=size(cal_syn_inh_data,2);
if cal_stats_plot==1
    h(fig_ind)=figure;
    plot(t_vec,sum(cal_syn_exc_data(ind_begin:ind_end,:)>theta_p,2)/n_syn_exc);
    hold on
    plot(t_vec,(sum(cal_syn_exc_data(ind_begin:ind_end,:)>theta_d,2)-sum(cal_syn_exc_data(ind_begin:ind_end,:)>theta_p,2))/n_syn_exc);
%     plot(t_vec,sum(cal_syn_inh_data(ind_begin:ind_end,:)>theta_p,2)/n_syn_inh,'-.');
    hold on
    plot(t_vec,sum(cal_syn_exc_data(ind_begin:ind_end,:)<theta_d,2)/n_syn_exc);

    xlim([t_begin t_end])
    grid on
     title(simname)
    fig_ind=fig_ind+1;
      xlabel('Time/s');
      legend ('Potentiating','Depressing','Still')
    xlim([t_begin t_end])
end
    

v_fire=v_data'>0;

if raster_plot==1
    h(fig_ind)=figure;
    imagesc(t_vec,1:N_sample,v_fire(:,ind_begin:ind_end))
    xlabel('Time/s');
    xlim([t_begin t_end])
    fig_ind=fig_ind+1;
     title(simname)
    set(gca,'FontSize',25)
    
end
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

% hold on
% plot([t_begin:time_bin:t_end-time_bin],movmean(fire_rate_exc_std./fire_rate_exc_mean,5),'LineWidth',2);
% hold on
% % plot([t_begin:time_bin:t_end-time_bin],movmean(fire_rate_exc_mean,10));
% % hold on
%  plot([t_begin:time_bin:t_end-time_bin],movmean(fire_rate_inh_std./fire_rate_inh_mean,5),'-.','LineWidth',2);


if v_plot==1
    h(fig_ind)=figure;
    plot(t_vec,v_avg(ind_begin:ind_end),'LineWidth',1)
    ylim([-80 30])
    hold on
%     plot(t_vec,v_data(:,1:20:end))
    grid on
    xlim([t_begin t_end])
%     ylim([-70 40])
    xlabel('Time/s');
    ylabel('Voltage')
     title(simname)
    set(gca,'FontSize',25)
    fig_ind=fig_ind+1;
end
% h(5)=figure
% plot(t_vec,mean(v_data(ind_begin:ind_end,1:N_exc),2),'LineWidth',2)
% hold on
% plot(t_vec,mean(v_data(ind_begin:ind_end,N_exc+1:end),2),'-.','LineWidth',2)
% grid on
% xlim([t_begin t_end])
% xlabel('Time/s');
% ylabel('Voltage')
% set(gca,'FontSize',20)
% legend('Exc V Mean','Inh V Mean')

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
v_avg_data=v_avg(ind_begin:ind_end,:);
v_fire_data=v_fire(:,ind_begin:ind_end);
vs_data=v_data(ind_begin:ind_end,:);
% bin_size=length(vs_data)/num_bin;
fire_result=zeros(N_sample,num_bin);
sync_result=zeros(1,num_bin);
spectrum_result=zeros(bin_size/2,num_bin);
for k = 1:num_bin
    fire_bin_data=v_fire_data(:,(k-1)*bin_size+1:k*bin_size);
    v_bin_data=vs_data((k-1)*bin_size+1:k*bin_size,:);
    v_avg_bin_data=v_avg_data((k-1)*bin_size+1:k*bin_size);
    avg_var=mean(std(v_bin_data).^2);
    sync_result(k)=std(v_avg_bin_data)^2/avg_var;
    fire_result(:,k)=sum(fire_bin_data,2)/time_bin;
    [f_result,p_result]=spectrum_ana(plot_dt,bin_size,v_avg_bin_data);
    spectrum_result(:,k)=p_result;
end


f_up=64;
f_ind=find(f_result==f_up);
s_plot=spectrum_result(1:f_up,:);

p_delta=sum(spectrum_result(1:4,:),1)./sum(spectrum_result,1); %delta 1-4Hz
p_alpha=sum(spectrum_result(5:8,:),1)./sum(spectrum_result,1); %theta 4-8Hz
p_theta=sum(spectrum_result(9:12,:),1)./sum(spectrum_result,1);%alpha 8-12
p_sigma=sum(spectrum_result(13:16,:),1)./sum(spectrum_result,1);%sigma 12-16
p_beta=sum(spectrum_result(17:32,:),1)./sum(spectrum_result,1); %beta 16-32

if spec_plot ==1
    h(fig_ind)=figure
    imagesc(t_vec,1:f_up,s_plot)
    colorbar
    pmax=max(max(s_plot));pmin=min(min(s_plot));
    plevel=20;pstep=(pmax-pmin)/20;
    caxis([pmin pmax-5*pstep])
    %  plot ([t_begin:time_bin:t_end-time_bin],movmean(p_delta,5),'LineWidth',2);hold on;plot ([t_begin:time_bin:t_end-time_bin],movmean(p_alpha,5),'LineWidth',2);hold on;
    %  plot ([t_begin:time_bin:t_end-time_bin],movmean(p_theta,5),'LineWidth',2);plot ([t_begin:time_bin:t_end-time_bin],movmean(p_sigma,5),'LineWidth',2);
    % hold on;plot ([t_begin:time_bin:t_end-time_bin],movmean(p_beta,5),'LineWidth',2);
    xlabel('Time/s')
    % ylabel('Power')
    ylabel('Frequency/Hz')
    set(gca,'FontSize',25)
    fig_ind=fig_ind+1;
end


% w_std_plot=w_stats_movmean(ind_begin:250:ind_end-1,3);
if fire_rate_plot ==1
    fire_rate_exc_std=std(fire_result(1:N_exc,:),[],1);fire_rate_exc_mean=mean(fire_result(1:N_exc,:),1);
    fire_rate_inh_std=std(fire_result(N_exc+1:end,:),[],1);fire_rate_inh_mean=mean(fire_result(N_exc+1:end,:),1);
    h(fig_ind)=figure
    plot([t_begin:time_bin:t_end-time_bin],movmean(fire_rate_exc_std./fire_rate_exc_mean,1),'LineWidth',2);
%     hold on
    % plot([t_begin:time_bin:t_end-time_bin],movmean(fire_rate_exc_mean,10));
    % hold on
%      plot([t_begin:time_bin:t_end-time_bin],movmean(fire_rate_inh_std./fire_rate_inh_mean,5),'-.','LineWidth',2);
    % hold on
    %plot([t_begin:time_bin:t_end-time_bin],movmean(fire_rate_inh_mean,10),'-.');
    grid on
    xlabel('Time/s')
    ylabel('Coef of Variation')
    fig_ind=fig_ind+1;
    set(gca,'FontSize',25)
end

if sync_plot==1
     h(fig_ind)=figure
     plot([t_begin:time_bin:t_end-time_bin],sync_result,'LineWidth',2);
     grid on
     xlabel('Time/s')
     ylabel('Syncrony Measure')
     set(gca,'FontSize',25)
end

% h(8)=figure
% plot([t_begin:time_bin:t_end-time_bin],movmean(skewness(fire_result(1:N_exc,:),1),5),'LineWidth',2);
% hold on
% % plot([t_begin:time_bin:t_end-time_bin],movmean(fire_rate_exc_mean,10));
% % hold on
%  plot([t_begin:time_bin:t_end-time_bin],movmean(skewness(fire_result(N_exc+1:end,:),1),5),'-.','LineWidth',2);
% % hold on
% %plot([t_begin:time_bin:t_end-time_bin],movmean(fire_rate_inh_mean,10),'-.');
% grid on
% xlabel('Time/s')
% ylabel('Skewness of Firing Rate Dist')

if firsttime
 savefig(h,figure_name);
end

