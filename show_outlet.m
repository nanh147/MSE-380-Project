function h = show_outlet(volume)
rho = 994;
tube_diameter = 0.02
tube_cross_section = pi*tube_diameter^2
tube_length = 1;
I_f = rho*tube_length/tube_cross_section
tank_area = 0.075;
C_grav = tank_area/rho*9.81;
R_f = 0.9;




A=[0 1/C_grav
    1/I_f -R_f/I_f];
B = [0 0
    0 0];
C = [1/rho*9.81 0];
D = [0 0];




shower = ss(A,B,C,D);
dt = 0.1;
final_t = 600;
t = 0:dt:final_t;
n=final_t/dt;
u(1:2,1:n+1) = 0;
IC = [0.8*rho*9.81 tank_area*sqrt(2*9.81*0.8)]

P10 = lsim(shower,u,t,IC);

figure;
plot(t,P10);
title('Shower Outlet');
end

