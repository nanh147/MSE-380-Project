function [maxvalues] = Motor(voltage_from_solar, t_final)
%MOTOR_FUNCTION Summary of this function goes here
%   Detailed explanation goes here


m_fly = 1;
J = m_fly*4e-2;
b = 0.01;
K = 0.01;
R = 1;
L = 0.5;
s = tf('s');

A = [-b/J   K/J
    -K/L   -R/L];
B = [0
    1/L];
C = [1   0];
C_prime = [0 1];
D = 0;
alpha_ss = ss(A,B,C,D);
current_ss = ss(A,B,C_prime,D);



dt = 0.005;
array_size = size(voltage_from_solar);
alpha = [0];
current = [0];
for i= 1:array_size(2)
    n = 3600/dt;
    %Input is voltage from Solar.
    u(1:1,1:n+1) = voltage_from_solar(i);
    IC = [alpha(end) current(end)];
    alpha = [alpha; lsim(alpha_ss,u,0:dt:3600,IC)];
    current = [current; lsim(current_ss,u,0:dt:3600,IC)];
end
maxvalues = [alpha(end) current(end)];
result_size = size(alpha);
t_final = (result_size-1) * dt;
t = 0:dt:t_final;
figure;
title('Motor Output');
subplot(1,2,1);
plot(t,alpha);
title('Motor Output');
xlabel('Time (s)');
ylabel('Angular Velocity');

subplot(1,2,2);
plot(t, current);
title('Motor Output');
xlabel('Time (s)');
ylabel('Current');
end
