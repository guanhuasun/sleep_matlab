%connectivity matrix is called w

%uniform random connection 

lamda=0.01; %probability of connection for each neuron

w=zeros(N_neuron,N_neuron);
conn_pern=ceil(lamda*N_neuron);
%N_connection=1;
%w_ind=randi(N_neuron,N_neuron,N_connection);

offset_list=zeros(1,N_neuron+1);
offset_list(1)=0;
n_conn=conn_pern*N_neuron; %number of connections
indices=zeros(N_neuron,conn_pern); %
weights=ones(n_conn,1); %weight vector
up_ind=zeros(1,n_conn); %
down_ind=zeros(1,n_conn);%
for i = 1:N_neuron
    rand_list=randperm(N_neuron);
    w_ind=rand_list(1:conn_pern);
    
    w(i,w_ind)=1;
    offset_list(i+1)=offset_list(i)+conn_pern;
    down_ind(offset_list(i)+1:offset_list(i+1))=w_ind;
    up_ind(offset_list(i)+1:offset_list(i+1))=i;
    indices(i,:)=w_ind;
end
conn_wind=find(w==1);

% 
% for j = 1:N_neuron
%     down_j=find(w(j,:)==1);
%     down_ind(j,1:length(down_j))=down_j;
% end
