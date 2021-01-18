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
sim('Simple_Quadcopter_Model_Sim_X_Yaw');

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

X_m1=(((pi/4)*l)+X);
Y_m1=-(((pi/4)*l)+Y);
X_m2=(((pi/4)*l)+X);
Y_m2=(((pi/4)*l)+Y);
X_m3=-(((pi/4)*l)+X);
Y_m3=(((pi/4)*l)+Y);
X_m4=-(((pi/4)*l)+X);
Y_m4=-(((pi/4)*l)+Y);

X1 = X_m1.*cos(Psi) - Y_m1.*sin(Psi);
Y1 = X_m1.*sin(Psi) + Y_m1.*cos(Psi);
X2 = X_m2.*cos(Psi) - Y_m2.*sin(Psi);
Y2 = X_m2.*sin(Psi) + Y_m2.*cos(Psi);
X3 = X_m3.*cos(Psi) - Y_m3.*sin(Psi);
Y3 = X_m3.*sin(Psi) + Y_m3.*cos(Psi);
X4 = X_m4.*cos(Psi) - Y_m4.*sin(Psi);
Y4 = X_m4.*sin(Psi) + Y_m4.*cos(Psi);

figure(fig)
fig=fig+1;
plot3(X,Y,Z,'lineWidth',3)
hold on
plot3(X1,Y1,Z,'--r','lineWidth',3)
plot3(X2,Y2,Z,'--k','lineWidth',3)
plot3(X3,Y3,Z,'--g','lineWidth',3)
plot3(X4,Y4,Z,'--m','lineWidth',3)
legend('Center of Mass','Motor 1','Motor 2','Motor 3','Motor 4')
grid on
title('Quadcopter Trajectory')
xlabel('X Position(m)')
ylabel('Y Position(m)')
zlabel('Z Position(m)')

