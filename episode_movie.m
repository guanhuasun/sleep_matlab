weight_movie=0;
freq_movie=0;
raster_movie=1;
voltage_movie=0;
hist_movie=0;
v = VideoWriter('35_55_firesqr_0.25speed.avi');
%v=VideoWriter('35_55_test.mov')

write_dt=4; %in ms
t_begin=35; %in seconds
t_end=55;%in seconds
ind_begin=floor(t_begin*1000/write_dt);
ind_end=ceil(t_end*1000/write_dt);
frame_sample=1;
frame_num=floor((ind_end-ind_begin)/frame_sample); %total number of frames
movie_length=80; %in seconds
v.FrameRate=floor(frame_num/movie_length);


if voltage_movie==1
    figure
    v_movmean=movmean(v_avg,25);
    open(v)
    plot([t_begin:write_dt/1000:t_end],v_movmean(ind_begin:ind_end));
    grid on
    set(gcf,'Position',[400 400 1600 400])
    hold on
    g=scatter(t_begin,v_movmean(ind_plot),'LineWidth',2.5);
    
    for ind_plot=ind_begin:frame_sample:ind_end
        t_plot=ind_plot*write_dt/1000;
        set(g,'xdata',t_plot,'ydata',v_movmean(ind_plot));
        drawnow
        title(sprintf('t=%g',t_plot));
        A=getframe(gcf);
        writeVideo(v,A);
    end
close(v)
end

if raster_movie==1
    figure
    open(v)
    v_grid=zeros(15,15);
    for ind_plot=ind_begin:frame_sample:ind_end
        t_plot=ind_plot*write_dt/1000;
        for k =1:15
            v_grid(k,:)=v_data(ind_plot,(k-1)*15+1:k*15);
        end
        heatmap(v_grid,'CellLabelColor','none');
        grid off
        caxis([-60,0])
        colormap(greenMap)
        drawnow
        A=getframe(gcf);
        writeVideo(v,A);
    end
close(v)
end




if hist_movie==1
    open(v)
    figure
    subplot(3,1,3)
    plot([t_begin:write_dt/1000:t_end],v_movmean(ind_begin:ind_end));
    hold on
    g=scatter(t_begin,v_movmean(ind_plot),'LineWidth',2.5);
    for ind_plot=ind_begin:frame_sample:ind_end
        t_plot=ind_plot*write_dt/1000;
        subplot(3,1,1)
        %histogram(w_exc_data(ind_plot,:));
        histogram(w_exc_data(ind_plot,:));
        subplot(3,1,2)
        %histogram(w_inh_data(ind_plot,:));
        set(g,'xdata',t_plot,'ydata',v_movmean(ind_plot));
        drawnow
        title(sprintf('t=%g',t_plot));
        set(gcf,'Position',[200 200 1600 1000])
        A=getframe(gcf);
        writeVideo(v,A);
    end
close(v)
end

if weight_movie==1
    figure
    for ind_plot = ind_begin:10:ind_end
        t_plot = ind_plot*plot_dt;
        w_exc_ind=w_exc_data(ind_plot,:);
    %     figure
%       fire_ind=fire_result();
        histogram(w_exc_ind,10);
%          histogram(fire_ind,10);
    %     hold on
        title_name=sprintf('t=%g',t_plot);
         title(title_name);
         pause(0.05)
        drawnow
    end
%     legend('Begin','End');
%     xlabel('Time/s');
%     set(gca,'FontSize',20)
end

if freq_movie==1
    figure
    for t_plot = t_begin+1:t_end
        ind_plot = t_plot-t_begin;
        spec_ind=spectrum_result(:,ind_plot);
        %bar(f_result,spec_ind);
        histogram(fire_result(:,ind_plot));
        title_name=sprintf('t=%g',t_plot);
         title(title_name);
         pause(0.2)
        drawnow
    end
%     legend('Begin','End');
%     xlabel('Time/s');
%     set(gca,'FontSize',20)
end