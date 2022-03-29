function [x_new] = exp_solve(x_old,a,b,dt)
%   this function updates x by solving dx/dt=a-bx analytically.
x_new=(x_old-a./b).*exp(-b*dt)+a./b;
end

