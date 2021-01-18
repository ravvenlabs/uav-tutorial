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
d = 9.94e-10;  % Drag factor 
l = 0.23;  % Distance to the center of the Quadrotor
g = 9.81;   % Gravitational acceleration
weight =.284; %kg  Weight=mg (from a scale)
m = weight/g;  % Mass of the Quadrotor in Kg
b_m=2.415e-6; %Motor damping
R=0.117; %Motor Resistance
L=0.001*R; %Electric Inductance
Kemf=0.00255; %Back electromotive force constant
Kt=Kemf;
C=700; %mAh
PD=120; %Peak Discharge
CD=60; %Constant Dishcharge
Amps=C/1000;
Operating_current=Amps*CD; 
Max_current=Amps*PD;
Volts=11.1;
Gyro_bias=0;
Accel_bias=0;
Phi_dot_bias=0;
Theta_dot_bias=0;
Psi_dot_bias=0;
X_dot_dot_bias=0;
Y_dot_dot_bias=0;
Z_dot_dot_bias=0;
Grav_bias=g;
%set_param('Controlled_simulink_model_vectorized','AlgebraicLoopSolver','LineSearch')
sim('Controlled_simulink_model_vectorized')

figure(fig)
fig=fig+1;
plot(time,Z_d,time,Z,'--','LineWidth',2)
title('Desired vs Actual Altitude')
xlabel('Time(s)')
ylabel('Altitude(m)')
legend('Desired','Actual')

figure(fig)
fig=fig+1;
plot(time,Phi_d,time,Phi,'--','LineWidth',2)
title('Desired vs Actual Roll')
xlabel('Time(s)')
ylabel('Angle(rad)')
legend('Desired','Actual')

figure(fig)
fig=fig+1;
plot(time,Theta_d,time,Theta,'--','LineWidth',2)
title('Desired vs Actual Pitch')
xlabel('Time(s)')
ylabel('Angle(rad)')
legend('Desired','Actual')


figure(fig)
fig=fig+1;
subplot(4,1,1)
plot(time,Z_d,time,Z,'--','LineWidth',2)
title('Altitude Control')
ylabel('Altitude(m)')
legend('Desired','Simulated')

subplot(4,1,2)
plot(time,Phi_d,time,Phi,'--','LineWidth',2)
title('Roll Control')
ylabel('Rad')

subplot(4,1,3)
plot(time,Theta_d,time,Theta,'--','LineWidth',2)
title('Pitch Control')
ylabel('Rad')

subplot(4,1,4)
plot(time,RPM_1,time,RPM_2,time,RPM_3,time,RPM_4,'LineWidth',2)
title('Motor RPM')
ylabel('RPM')
xlabel('Time(s)')

figure(fig)
fig=fig+1;
plot3(X,Y,Z,'lineWidth',3)
grid on
title('Quadcopter Trajectory')
xlabel('X Position(m)')
ylabel('Y Position(m)')
zlabel('Z Position(m)')

figure(fig)
fig=fig+1;
plot(time,X_dot_dot,time,Y_dot_dot,time,Z_dot_dot)
ylabel('Acceleration m/s^2')
xlabel('Time(s)')
legend('X Accel','Y Accel','Z Accel')
title('IMU Acceleration reading')

figure(fig)
fig=fig+1;
plot(Sensor_x_pos,Sensor_y_pos,'lineWidth',2)
xlabel('X position(m)')
ylabel('Y position(m)')
title('Sensor Position Reading')

figure(fig)
fig=fig+1;
plot(X,Y,'lineWidth',2)
xlabel('X position(m)')
ylabel('Y position(m)')
title('Plant Position')

figure(fig)
fig=fig+1;
plot(time,X_dot_dot_plant,time,Y_dot_dot_plant,time,Z_dot_dot_plant)
ylabel('Acceleration m/s^2')
xlabel('Time(s)')
legend('X Accel','Y Accel','Z Accel')
title('Plant Acceleration')

