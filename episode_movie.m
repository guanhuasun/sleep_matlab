weight_movie=0;
freq_movie=0;
raster_movie=1;

v = VideoWriter('test.avi');


write_dt=1; %in ms
t_begin=2000+write_dt;
t_end=3000;%in ms
ind_begin=floor(t_begin/write_dt);
ind_end=ceil(t_end/write_dt);
frame_sample=1;
frame_num=floor((ind_end-ind_begin)/frame_sample); %total number of frames
movie_length=50; %in seconds
v.FrameRate=floor(frame_num/movie_length);
open(v)
if raster_movie==1
    figure
    v_grid=zeros(15,15);
    for ind_plot=ind_begin:frame_sample:ind_end
        for k =1:15
            v_grid(k,:)=v_data(ind_plot,(k-1)*15+1:k*15);
        end
        heatmap(v_grid,'CellLabelColor','none');
        caxis([-60,10])
        drawnow
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