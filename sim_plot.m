%sim_plot
close all
if_v_plot=0;
if_w_plot=0;
if_avg_plot=0;
if_spect_plot=1;
if_hist_plot=0;

t_vec=[write_dt:write_dt:T];

figure
cal_plot=plot(t_vec,cal_data(:,1:end),'LineWidth',1.5);
grid on
xlabel('Time/ms');
ylabel('[Ca] of Neurons');
set(gca,'FontSize',25)

if if_v_plot
    figure
    v_plot=plot(t_vec,v_data(:,1:end),'LineWidth',1.5);
    grid on
    xlabel('Time/ms');
    ylabel('V of Neurons');
    set(gca,'FontSize',25)
end

figure
v_fire=v_data'>0;
imagesc(v_fire)

if if_w_plot
    figure
    v_plot=plot(t_vec,w_data(:,1:end),'LineWidth',1.5);
    grid on
    xlabel('Time/ms');
    ylabel('Synaptic Weights');
    set(gca,'FontSize',25)
end

if if_avg_plot
    figure
    v_plot=plot(t_vec,v_avg,'LineWidth',1.5);
    grid on
    xlabel('Time/ms');
    ylabel('Average Voltage');
    set(gca,'FontSize',25)
end

if if_spect_plot
    spectrum_ana;
end


% makevideo=0;
% if makevideo
%     video_name=sprintf('wake_calcium_p%ud%u.mov',theta_p*10,ceil(theta_d*10));
%     sim_video = VideoWriter(video_name);
%     VideoW.FrameRate = 40;
%     open(sim_video);
% end
% tmax=10;
% 
% if plot_yes
%     for num_frame=0:400:4*124800
%         fname=sprintf("RHO_"+sim_name+"_%u.txt",num_frame);
%         fname=fullfile(folder,fname);
%         rho_list=readmatrix(fname);
%         rho_list=rho_list(1:end-1);
%         rho_s=rho_list(rho_list<100);
%         if min(rho_list)<0 || max(rho_list)>100
%             pause;
%         end
%         rho_avg=sum(rho_s)/length(rho_s);
%         rho_std=sqrt(sum((rho_s-rho_avg).^2)/length(rho_s));
%         result(i,:)=[min(rho_s) max(rho_s) rho_avg rho_std]; 
%         t_sim=num_frame/249800*tmax;
%         
%         plot_his=0;
% 
%             title_name=sprintf('t=%g',t_sim);
%         if plot_his ==1
%             histogram(rho_s)
%             title(title_name);
%             xlim([0 1.5])
%             %ylim([0 3000])
%             set(gca,'FontSize',20)
%             grid on
%             xlabel('Synaptic Weights');
%             ylabel('Occurences')
%             drawnow
%         end
%         
%         plot_conn=1;
%         
%         if plot_conn
%             for ind_n = 1:N
%                 low_ind=offset_list(ind_n)+1;
%                 up_ind=offset_list(ind_n+1);
%                 conn_list_n=indices_list(low_ind:up_ind)+1;
%                 w_plot(ind_n,conn_list_n)=rho_list(low_ind:up_ind);
%                 if ind_n == 100
%                     histogram(rho_list(low_ind:up_ind))
%                     title(title_name);
%                     xlim([0 1])
%                     drawnow
%                 end
%             end 
% %             plot_conn=heatmap(w_plot(1:100,1:100));
% %             title(title_name);
% %             caxis([0 1])
% %             grid off
% %             plot_conn.XDisplayLabels = nan(size(plot_conn.XDisplayData));
% %             plot_conn.YDisplayLabels = nan(size(plot_conn.YDisplayData));
% %             drawnow
%         end
% 
%         if makevideo
%             frame = getframe(gcf);
%             writeVideo(sim_video,frame);
%         end
%         i=i+1;
%     end
%     
%     if makevideo
%         close(sim_video);
%     end
% end
