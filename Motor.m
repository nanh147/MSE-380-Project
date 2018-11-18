function [maxvalues] = Motor(voltage_from_solar)
%MOTOR_FUNCTION Summary of this function goes here
%   Detailed explanation goes here
dt = 0.01;
t_final = 3.5;
t = 0:dt:t_final;
n=t_final/dt;
J = 0.01;
b = 0.1;
K = 0.01;
R = 1;
L = 0.5;
s = tf('s');
P_motor = K/((J*s+b)*(L*s+R)+K^2);

A = [-b/J   K/J
    -K/L   -R/L];
B = [0
    1/L];
C = [1   0];
C_prime = [0 1];
D = 0;
motor_ss = ss(A,B,C,D)
generator_ss = ss(A,B,C_prime,D)
%Input is voltage from Solar.
u(1:1,1:n+1) = voltage_from_solar;
IC = [0 0];
alpha = lsim(motor_ss,u,t,IC);
current = lsim(generator_ss,u,t,IC);
maxvalues = [max(alpha(:)) max(current(:))];
figure;
plot(t,alpha,t, current);
title('Motor/Generator Output');
xlabel('Time (s)');
ylabel('Angular Acceleration/Current');
legend('Angular Acceleration','Current');
end
