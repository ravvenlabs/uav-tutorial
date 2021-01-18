%Nicholas Ferry
%Rochester Institute of Technolgoy
%Quadcopter Battery model
clc
clear all
close all
fig=1;

fig=1;
global Jr Ixx Iyy Izz b d l m g b_m R L Ke
TF=10;

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
[Data,Header,raw]=xlsread('Continuous_2017-11-01_145046_10inc_0to2000andBack.csv');
[M,I] = max(Data(:,12));
Time=Data(1:I,1);
Voltage=Data(1:I,11);
Current=Data(1:I,12);
RPM=Data(1:I,14);
Data=Data(1:I,:);

sim('Battery_Motor')

figure(fig)
fig=fig+1;
subplot(2,1,1)
plot(time,Voltage_)
title('Experimental Battery Voltage')
ylabel('Voltage(v)')
subplot(2,1,2)
plot(time,Current_)
title('Experimental Battery Current')
ylabel('Current(A)')
xlabel('Time(s)')

figure(fig)
fig=fig+1;
subplot(2,1,1)
plot(Data(:,1),Data(:,11))
hold on
plot(time,Voltage_)
title('Experimental Battery Voltage')
ylabel('Voltage(v)')
legend('Experimental','Simulated')
subplot(2,1,2)
plot(Data(:,1),Data(:,12))
hold on
plot(time,Current_)
title('Experimental Battery Current')
ylabel('Current(A)')
xlabel('Time(s)')



