exc_conn_name='w_exc_conn.mat';exc_conn_name=fullfile(foldername,exc_conn_name);
inh_conn_name='w_inh_conn.mat';inh_conn_name=fullfile(foldername,inh_conn_name);
syn_input_name='syn_input_data.mat';syn_input_name=fullfile(foldername,syn_input_name);
w_excname='w_exc_data.mat';w_excname=fullfile(foldername,w_excname);
w_inhname='w_inh_data.mat';w_inhname=fullfile(foldername,w_inhname);
cal_excname='cal_exc_data.mat';cal_excname=fullfile(foldername,cal_excname);
cal_inhname='cal_inh_data.mat';cal_inhname=fullfile(foldername,cal_inhname);
save(w_excname,'w_exc_data');save(w_inhname,'w_inh_data');save(cal_excname,'cal_syn_exc_data');save(cal_inhname,'cal_syn_inh_data');
save(syn_input_name,'syn_input_data');save(exc_conn_name,'w_exc');save(inh_conn_name,'w_inh');