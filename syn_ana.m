write_dt=0.004; %in second

t_check=[1:500]; %enter all time we want to check the synaptic weight distribution

for t_plot = t_check
    ind_plot=t_plot/write_dt;
    %figure
    histogram(w_data(ind_plot,:));
    drawnow
end