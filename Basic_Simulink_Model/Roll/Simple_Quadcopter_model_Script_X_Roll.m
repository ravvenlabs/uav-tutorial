%Nicholas Ferry
%Rochester Institute of Technology
%Quadcopter Plant Model X orientation
clc
clear all
close all
fig=1;
global Jr Ixx Iyy Izz b d l m g 


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
l = 0.1;  % Distance to the center of the Quadrotor
g = 9.81;   % Gravitational acceleration
weight =.284; %kg  Weight=mg (from a scale)
m = weight/g;  % Mass of the Quadrotor in Kg
TF=30; %Simulation time

sim('Simple_Quadcopter_Model_Sim_X_Roll');

figure(fig)
fig=fig+1;
plot(time,Phi,time,Theta,time,Psi)
title('Body Angles (rad)')
xlabel('Time(s)')
ylabel('rad')
legend('Phi','Theta','Psi')

figure(fig)
fig=fig+1;
plot(time,X,time,Y)
title('X and Y position')
xlabel('Time(s)')
ylabel('Postion (m)')
legend('X', 'Y')

figure(fig)
fig=fig+1;
plot(time,Z)
title('Altitude')
xlabel('Time(s)')
ylabel('Altitude (m)')

figure(fig)
fig=fig+1;
plot3(X,Y,Z,'lineWidth',3)
grid on
title('Quadcopter Trajectory')
xlabel('X Position(m)')
ylabel('Y Position(m)')
zlabel('Z Position(m)')

