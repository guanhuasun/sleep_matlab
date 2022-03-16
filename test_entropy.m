N=500;
fire_freq=lognrnd(0,0.5,[N 1]);
T=500;
dt=0.02;
nstep=T/dt;
result=zeros(N,nstep);
for i=1:nstep
    t=i*dt;
    result(:,i)=rand(N,1)<fire_freq*dt;
end