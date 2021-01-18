%Nicholas Ferry
%Rochester Institute of Technology
%Controlled Plant Model
clc
clear all
fig=1;
global Jr Ixx Iyy Izz Ax Ay Az b d l m g b_m R L weight

% Quadrotor constants
Ixx = 7.5*10^(-3);  % Quadrotor moment of inertia around X axis
Iyy = 7.5*10^(-3);  % Quadrotor moment of inertia around Y axis
Izz = 1.3*10^(-2);  % Quadrotor moment of inertia around Z axis
Ax=0.0;
Ay=0.0;
Az=0.0;
Jr = 6.5*10^(-7);  % Total rotational moment of inertia around the propeller axis 6.5*10^(-6)
b = 1.144e-08;  % Thrust factor
d = 9.94e-10;  % Drag factor 1.0876e-9
l = 0.23;  % Distance to the center of the Quadrotor
g = 9.81;   % Gravitational acceleration
weight =.284; %kg  Weight=mg (from a scale)
m = weight/g;  % Mass of the Quadrotor in Kg
b_m=2.415e-6;
R=0.117; %Motor Resistance
L=0.001*R; %Electric Inductance
Kemf=0.00255; %Back electromotive force constant
Kt=Kemf;
Gyro_bias=0;
Accel_bias=0;
Phi_dot_bias=0;
Theta_dot_bias=0;
Psi_dot_bias=0;
X_dot_dot_bias=0;
Y_dot_dot_bias=0;
Z_dot_dot_bias=0;
Grav_bias=g;
%set_param('Controlled_simulink_model_optimal','AlgebraicLoopSolver','LineSearch')

global Kp Ki Kd 
format short e
Kp=1;
Ki=1;
Kd=1;
x0=[Kp; Ki;Kd];
x=fminsearch('OptPID',x0)
Kp=x(1)
Ki=x(2)
Kd=x(3)
sim('Controlled_simulink_model_optimal')

figure(fig)
fig=fig+1;
yyaxis left
plot(time,Z_d,'b',time,Z,'r--','LineWidth',2)
title('Desired vs Actual Altitude')
xlabel('Time(s)')
ylabel('Altitude(m)')
yyaxis right
plot(time,U,'LineWidth',2)
grid on
ylabel('Thrust Input')
legend('Desired','Actual','Input')

