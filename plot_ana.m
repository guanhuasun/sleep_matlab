T=10000;
write_dt=1;
num_frame=ceil(T/write_dt);
dt=[0.02];
n_method=2;
N_neuron=250;
SampleRate=1/(write_dt/1000);
for w_s=[0.1:0.1:1] 
     
    dirname=('../noise_test3_sigma1');
    simname=sprintf('n%uw%gdt%grk4',N_neuron,w_s,dt);
    foldername=fullfile(dirname,simname);
    vname=simname+"_v.mat";calname=simname+"_cal.mat";
    vname=fullfile(foldername,char(vname));
    calname=fullfile(foldername,char(calname));
    load(vname);
    v_avg=sum(v_data,2)/N_neuron;
    pspectrum(v_avg,SampleRate,'FrequencyResolution',1,'spectrogram',...
        'FrequencyLimits',[0 100])
%     xlim([0 100])
    %hold on
end


