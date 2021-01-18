function [ J ] = OptPID( x )
global Kp Ki Kd 

Kp=x(1);
Ki=x(2);
Kd=x(3);

[Tsim,Xsim,Ysim]=sim('Controlled_simulink_model_optimal');

Q=1;
R=10;
error=(Ysim(:,2)-Ysim(:,1));
U=Ysim(:,3);
J=trapz(Q*error.*error+R*U.*U)*0.01;
end

