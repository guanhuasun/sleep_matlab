T=10000;
write_dt=0.01;
num_frame=ceil(T/write_dt);
dt=[0.01];
n_method=2;
N_neuron=250;
SampleRate=1/(write_dt/1000);
plot_i=1;
t_vec=[dt:dt:T];
for w_bar=[0.1:0.1:1] 
    %figure
    %plot_i=1;
    for w_sigma_relative=[0:0.03:0.3]
    w_sigma=[0:0.05:0.3]
    %dirname=('../w_gaussian_noise_3')
    dirname=('../w_gaussian_wonoise');
    simname=sprintf('n%uw%gwsn%gdt%grk4',N_neuron,w_bar,w_sigma_relative,dt)
%     simname=sprintf('n%uw%gws%gdt%grk4',N_neuron,w_bar,w_sigma,dt)
    foldername=fullfile(dirname,simname);
    vname=simname+"_v.mat";calname=simname+"_cal.mat";
    vname=fullfile(foldername,char(vname));
    calname=fullfile(foldername,char(calname));
    load(vname);
    %v_avg=sum(v_data,2)/N_neuron;
    subplot(11,10,plot_i)
    %pspectrum(v_avg,SampleRate,'FrequencyLimits',[1 64],'FrequencyResolution',0.5)
     %ylim([-20,20])
    %hold on
    % plot(v_avg)
    % ylim([-80 -20])
     set(gca,'xtick',[])
     episode_ana;
    plot_i=plot_i+1;
   % drawnow%'spectrogram',...
        %'FrequencyLimits',[0 100])
%     xlim([0 100])
    %hold on
    end
%     fname=sprintf('n%uw_bar%gdt%grk4_wsn03_3.fig',N_neuron,w_bar,dt);
%     savefig(fname);
end


