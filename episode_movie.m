weight_movie=0;
freq_movie=1;
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