%Nicholas Ferry
%Rochester Institute of Technology
%Quadcopter Plant + Motor Dynamics
fig=1;
global Jr Ixx Iyy Izz b d l m g b_m R L 
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
b_m=2.415e-6;
R=0.117; %Motor Resistance
L=0.001*R; %Electric Inductance
Kemf=0.00255; %Back electromotive force constant
Kt=Kemf;
tf1=tf([0.001993 3.111e7],[1 1004 8.304e4]);
%tf1=tf([-7.199e6 1.167e12], [1 8.579e4 3.115e9]);
[Data,Header,raw]=xlsread('Continuous_2017-11-01_145046_10inc_0to2000andBack.csv');
Data=Data(1000:end-1000,:);
figure(fig)
fig=fig+1;
yyaxis left
plot(Data(:,1),(-Data(:,9)./((Data(:,14)*2*pi/60).^2)));
Ke_measured=median((-Data(:,9)./((Data(:,14)*2*pi/60).^2)));
title('Torque coefficient')
xlabel('Time(s)')
ylabel('Coefficient')
hold on
yyaxis right
plot(Data(:,1),0.001.*Data(:,10))
ylabel('Thrust(kg)')

figure(fig)
fig=fig+1;
for indx=1:1:length(Data(:,1))
    plot(0.001.*Data(indx,10),(-Data(indx,9)./((Data(indx,14)*2*pi/60).^2)),'.b')
    hold on
end
xlabel('Thrust(kg)')
ylabel('Coefficient(Nm/s^2)')
title('Torque Coefficient')
grid on

figure(fig)
fig=fig+1;
yyaxis left
plot(Data(:,1),(0.001*Data(:,10)./((Data(:,14)*2*pi/60).^2)));
b_c=median(0.001*(Data(:,10)./((Data(:,14)*2*pi/60).^2)));
title('Thrust Coefficient')
xlabel('Time(s)')
ylabel('Coefficient(N/s^2)')
hold on
yyaxis right
plot(Data(:,1),0.001.*Data(:,10))
ylabel('Thrust(kg)')

figure(fig)
fig=fig+1;
for indx=1:1:length(Data(:,1))
    plot(0.001.*Data(indx,10),(0.001*Data(indx,10)./((Data(indx,14)*2*pi/60).^2)),'.b')
    hold on
end
xlabel('Thrust(kg)')
ylabel('Coefficient(N/s^2)')
title('Thrust Coefficient')
grid on

figure(fig)
fig=fig+1;
yyaxis left
plot(Data(:,1),(-Data(:,9)./((Data(:,14)*2*pi/60))));
b_damp=median((-Data(:,9)./((Data(:,14)*2*pi/60))));
title('Motor damping coefficient')
xlabel('Time(s)')
ylabel('Coefficient')
hold on
yyaxis right
plot(Data(:,1),0.001.*Data(:,10))
ylabel('Thrust(kg)')

figure(fig)
fig=fig+1;
for indx=1:1:length(Data(:,1))
    plot(0.001.*Data(indx,10),(-Data(indx,9)./((Data(indx,14)*2*pi/60))),'.b')
    hold on
end
title('Motor Damping Coefficient')
xlabel('Thrust(kg)')
ylabel('Coefficient (Nm/A)')
grid on

figure(fig)
fig=fig+1;
yyaxis left
plot(Data(:,1),(-Data(:,9)./(Data(:,12))));
Kt=median((-Data(:,9)./(Data(:,12))));
title('Motor Torque Coefficient')
xlabel('Time(s)')
ylabel('Coefficient')
hold on
yyaxis right
plot(Data(:,1),0.001.*Data(:,10))
ylabel('Thrust(kg)')

figure(fig)
fig=fig+1;
for indx=1:1:length(Data(:,1))
    plot(0.001.*Data(indx,10),(-Data(indx,9)./(Data(indx,12))),'.b')
    hold on
end
title('Motor Torque Coefficient')
xlabel('Thrust(kg)')
ylabel('Coefficient(Nms)')
grid on

sim('Motor_Dynamics')


figure(fig)
fig=fig+1;
plot(time,Velocity)
title('Motor Dynamics Angular Velocity Step Response')
xlabel('Time(s)')
ylabel('Angular Velocity (rad/s)')

figure(fig)
fig=fig+1;
plot(time,Velocity)
hold on
step(tf1,'--r')
title('Actual vs Estimated Step Response')
ylabel('Velocity(rad/s)')
legend('Actual','Transfer Function')

figure(fig)
fig=fig+1;
margin(tf1)
grid on
title('Motor Model FRF')

figure(fig)
fig=fig+1;
pzmap(tf1)
title('Pole-Zero Map of Motor Model')

figure(fig)
fig=fig+1;
rlocus(tf1)

OL_Data=iddata(Velocity_,Voltage_,0.0001);
OL_TF=arx(OL_Data,[2 1 1]);
OL_TF=d2c(OL_TF,'Tustin');
figure(fig)
fig=fig+1;
bode(OL_TF)
grid on
title('Open loop bode plot')

CL_Data=iddata(Output,Input,0.0001);
CL_TF=arx(CL_Data,[2 1 1]);
CL_TF=d2c(CL_TF,'Tustin');

figure(fig)
fig=fig+1;
hold on
%bode(tf1)
bode(CL_TF)
grid on
%legend('Open Loop Motor Plant Model','Closed Loop System')
title('Closed loop bode plot')

figure(fig)
fig=fig+1;
bode(OL_TF)
hold on
grid on
bode(CL_TF)


figure(fig)
fig=fig+1;
plot(time1,Output)
hold on
plot(time1,Input)
title('Contolled Motor Dynamics')
xlabel('Time(s)')
ylabel('Angular Velocity (rad/s)')
legend('Output','Input')

figure(fig)
fig=fig+1;
plot(time,Output1)
hold on
plot(time,Input1)
title('Closed Loop System')
xlabel('Time(s)')
ylabel('Angular Velocity (rad/s)')
legend('Output','Input')

figure(fig)
fig=fig+1;
subplot(2,1,1)
plot(time,Sin_input_1hz)
title('Motor Model Input 1 Rad/s')
ylabel('Input Amplitude')
subplot(2,1,2)
plot(time,Motor_out_1hz)
axis([0 10 1900 2100])
title('Motor Model Output')
ylabel('Output Amplitude')
xlabel('Time(s)')

figure(fig)
fig=fig+1;
subplot(2,1,1)
plot(time,Sin_input_100hz)
axis([0 1 1900 2100])
title('Motor Model Input 1000 Rad/s')
ylabel('Input Amplitude')
subplot(2,1,2)
plot(time,Motor_out_100hz)
axis([.1 1 2050 2150])
title('Motor Model Output')
ylabel('Output Amplitude')
xlabel('Time(s)')



