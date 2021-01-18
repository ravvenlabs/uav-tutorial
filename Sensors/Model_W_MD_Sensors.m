%Nicholas Ferry
%Rochester Institute of Technology
%Quadcopter Sensor Model
clc
clear all
fig=1;
global Jr Ixx Iyy Izz b d l m g b_m R L Ke
TF=50;
% Quadrotor constants
Ixx = 7.5*10^(-3);  % Quadrotor moment of inertia around X axis
Iyy = 7.5*10^(-3);  % Quadrotor moment of inertia around Y axis
Izz = 1.3*10^(-2);  % Quadrotor moment of inertia around Z axis
Jr = 6.5*10^(-7);  % Total rotational moment of inertia around the propeller axis 6.5*10^(-6)
b = 1.144e-08;  % Thrust factor
d = 9.94e-10;  % Drag factor 1.0876e-9
l = 0.23;  % Distance to the center of the Quadrotor
g = 9.81;   % Gravitational acceleration
weight =.284; %kg  Weight=mg (from a scale)
m = weight/g;  % Mass of the Quadrotor in Kg
b_m=2.415e-6;%Motor damping
R=0.117; %Motor Resistance
L=0.001*R; %Electric Inductance
Kemf=0.00255; %Back electromotive force constant
Kt=Kemf;
C=700; %mAh
PD=120; %Peak Discharge
CD=0.7; %Constant Dishcharge
Amps=C/1000;
Operating_current=Amps*CD; 
Max_current=Amps*PD;
Volts=11.1;
Gyro_bias=.6;
Accel_bias=1;
Phi_dot_bias=0;
Theta_dot_bias=0;
Psi_dot_bias=0;
X_dot_dot_bias=0;
Y_dot_dot_bias=0;
Z_dot_dot_bias=0;
Grav_bias=g;

sim('Plant_Model_W_Sensors_biased')
Phi_dot_bias=mean(Phi_dot);
Theta_dot_bias=mean(Theta_dot);
Psi_dot_bias=mean(Psi_dot);
X_dot_dot_bias=mean(X_dot_dot);
Y_dot_dot_bias=mean(Y_dot_dot);
Z_dot_dot_bias=mean(Z_dot_dot);
sim('Plant_Model_W_Sensors_Un_biased')
figure(fig)
fig=fig+1;
plot(time,Phi_dot,time,Theta_dot,time,Psi_dot)
hold on
plot(time,Phi_dot_B,time,Theta_dot_B,time,Psi_dot_B)
title('Gyroscope Bias Removal')
xlabel('Time(s)')
ylabel('Angle (rad)')
legend('Phi Vel Biased','Theta Vel Biased','Psi Vel Biased','Phi Vel Unbiased','Theta Vel Unbiased','Psi Vel Unbiased')
figure(fig)
fig=fig+1;
plot(time,Z_dot_dot,time,Y_dot_dot,time,X_dot_dot)
hold on
plot(time,Z_dot_dot_B,time,Y_dot_dot_B,time,X_dot_dot_B)
title('Accelerometer Bias Removal')
xlabel('Time(s)')
ylabel('Acceleration (m/s^2)')
legend('Z Accel Biased','Y Accel Biased','X Accel Biased','Z Accel Unbiased','Y Accel Unbiased','X Accel Unbiased')

figure(fig)
fig=fig+1;
subplot(2,1,1)
plot(time,Phi_dot_B,time,Theta_dot_B,time,Psi_dot_B)
title('Gyroscope Angular Outputs')
ylabel('Ang Vel(Rad/s)')
subplot(2,1,2)
plot(time,Phi,time,Theta,time,Psi)
title('Plant Angular Outputs')
xlabel('Time(s)')
ylabel('Angle(Rad)')

figure(fig)
fig=fig+1;
subplot(2,1,1)
plot(time,X_dot_dot_B,time,Y_dot_dot_B)
title('Accelerometer Outputs')
ylabel('Acceleration (m/s^2)')
subplot(2,1,2)
plot(time,X,time,Y)
title('Plant Position Outputs')
ylabel('Position(m)')
xlabel('Time(s)')

