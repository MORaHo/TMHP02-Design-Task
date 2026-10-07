%Normalised piston velocities [-]
v_p01 = [0 0.13 0.26 0.4 0.386 0.372 0.358 0.344 0.33 0.316 0.302 0.288 0.274 0.26 0.246 0.232 0.218 0.204 0.19 0.176 0.162 0.148 0.134 0.12 0.106 0.092 0.078 0.064 0.05 0.036 0.022 0.008 0 0 0 0 0 0 0 0 0];
v_p02 = [0 -0.1 -0.2 -0.2 -0.2 -0.2 -0.2 -0.2 -0.2 -0.2 -0.16 -0.12 -0.08 -0.04 0 0.04 0.08 0.12 0.16 0.2 0.24 0.28 0.32 0.36 0.4 0.44 0.48 0.52 0.56 0.6 0.64 0.68 0.72 0.76 0.8 0.5333333333 0.26666667 0 0 0 0];

%Lever arms [m]
e_1 = [0.322 0.3192 0.3164 0.3136 0.3108 0.308 0.3052 0.3024 0.2996 0.2968 0.294 0.2912 0.2884 0.2856 0.2828 0.28 0.278 0.276 0.274 0.273 0.272 0.271 0.27 0.269 0.268 0.2674 0.2668 0.2662 0.2656 0.265 0.265 0.265 0.267 0.267 0.267 0.267 0.267 0.267 0.267 0.267 0.267];
e_2 = [0.535 0.5365 0.538 0.539125 0.54025 0.541 0.54175 0.5425 0.54325 0.543625 0.544 0.544 0.544 0.5439 0.5437 0.5435 0.543 0.542 0.541 0.54 0.53875 0.537 0.535 0.533 0.531 0.529 0.526 0.523 0.52 0.516 0.512 0.506 0.5 0.492 0.492 0.492 0.492 0.492 0.492 0.492 0.492];

%Angles [rad]
th_1 = [0.55 0.56 0.57 0.585 0.6 0.62 0.65 0.67 0.7 0.73 0.76 0.78 0.8 0.815 0.835 0.85 0.87 0.885 0.9 0.915 0.93 0.945 0.96 0.97 0.98 0.99 0.995 1.005 1.01 1.015 1.02 1.02 1.02 1.012 1 1 1 1 1 1 1];
th_2 = [-0.62 -0.62 -0.61 -0.6 -0.585 -0.57 -0.55 -0.53 -0.51 -0.495 -0.48 -0.46 -0.44 -0.42 -0.4 -0.38 -0.36 -0.345 -0.32 -0.3 -0.28 -0.26 -0.24 -0.22 -0.2 -0.175 -0.15 -0.12 -0.09 -0.06 -0.03 0 0.04 0.08 0.12 0.12 0.12 0.12 0.12 0.12 0.12];

% Add mirrored movement to vectors
v_p01 = [v_p01 -fliplr(v_p01)];
v_p02 = [v_p02 -fliplr(v_p02)];
e_1 = [e_1 fliplr(e_1)];
e_2 = [e_2 fliplr(e_2)];
th_1 = [th_1 fliplr(th_1)];
th_2 = [th_2 fliplr(th_2)];

%Base height [m]
L_0 = 3;

%Worst case scenarios

%% Cylinder 1
th_1_wc_cyl1 = 1.2; 
th_2_wc_cyl1 = 0.0; 
e_1_wc_cyl1 = 0.14; 
e_2_wc_cyl1 = 0.57; 

%% Cylinder 2
th_1_wc_cyl2 = 0.35; 
th_2_wc_cyl2 = 0.0; 
e_1_wc_cyl2 = 0.48; 
e_2_wc_cyl2 = 0.17; 

%Group-specific values
M_tmax = 1800;
q_rwc = 0.9;
M_t = 1500;
L_1 = 1.9;
L_2 = 3.5;
v_p0 = 0.13;
t_0 = 10;
P_smax = 30000000;
p_1max = 30000000 - 2000000;
eta_c = 0.94;

p_2 = 1000000;

%Efficiency Coefficients

c_v = 1.3e-9;
k_p = 5.4e-2;
k_v = 6.5e-5;
k_eps = 0.3;
eta = 0.03;

% Constants and Time

g = 9.81;
time = linspace(0,t_0,length(e_1));

%De-normalise velocity

v_p1 = v_p0*v_p01;
v_p2 = v_p0*v_p02;

% Task 1.a

figure(1);

plot(time,e_1);
hold on
plot(time,e_2);

legend("e_1","e_2")
xlabel("Time (s)")
ylabel("e1, e2 (m)")
title("Arm Length vs Time")

az = L_1 * sin(th_1);
ax = L_1 * cos(th_1);
bz = L_2 * sin(th_2) + az + L_0;
bx = L_2 * cos(th_2) + ax;

figure(2);
plot(time,bz);
xlabel("Time (s)")
ylabel("z of tip (m)")
title("Crane Tip Height vs Time")

figure(3);
plot(bx,bz);
xlabel("X of tip (m)")
ylabel("Z of tip (m)")
title("Crane Tip Z vs Crane Tip X")


%% Task 1.b

F_1 = M_t*g*(L_1*cos(th_1)+L_2*cos(th_2))./e_1;
F_2 = M_t*g*L_2*cos(th_2)./e_2;

figure(4);
plot(time,F_1);
hold on
plot(time,F_2);
title("Force on Cylinders vs Time");
ylabel("Force on Cylinder (N)");
xlabel("Time (s)");
legend("F_1","F_2");

%% Task 2.a

F_wc_1 = M_tmax*g*(L_1*cos(th_1_wc_cyl1)+L_2*cos(th_2_wc_cyl1))./e_1_wc_cyl1; %%I put max of e_1 before, so now it's bigger, but more correct
F_wc_2 = M_tmax*g*L_2*cos(th_2_wc_cyl2)./e_2_wc_cyl2; %% I put max of e_2 before, so now it's bigger, but more correct.

A_1 = F_wc_1/(eta_c*(p_1max-0.5*p_2)) % 0.020437
D_1 = sqrt(4*A_1/pi) % 0.1613
A_2 = F_wc_2/(eta_c*(p_1max-0.5*p_2)) % 0.014064
D_2 = sqrt(4*A_2/pi) % 0.1338

% Task 2.b

%{
17We've chosen a CGH3 type hydraulic cylinder with 180mm diameter for the first cylinder,
and an 140mm bore diameter CGH3 cylinder for the second cylinder.
%}

%% Chosen Areas %%

A_p1 = 0.025447;
A_r1 = 0.013175;
A_p2 = 0.015394;
A_r2 = 0.007540;

%% Checking that the velocity is below the required velocity

v_max_1 = 0.14*ones(length(time),1); %we haven't chosen this value yet
v_max_2 = 0.16*ones(length(time),1); %we haven't chosen this value yet

figure(5);
plot(time,v_max_1);
hold on
plot(time,abs(v_p1));
plot(time,v_max_2);
plot(time,abs(v_p2));
legend("Max Stroke Speed: Cylinder 1","Stroke Speed (Magnitude): Cylinder 1","Max Stroke Speed: Cylinder 2","Stroke Speed (Magnitude): Cylinder 2");
xlabel("Time (s)");
ylabel("Velocity (m/s)");
title("Magnitude of Velocity vs Time")

% Task 3.a

v_1_pos = v_p1 > 0;
v_1_neg = v_p1 < 0;
v_1_stat = v_p1 == 0;
eta_c1 = v_1_pos./eta_c + v_1_neg*eta_c + v_1_stat;
v_2_pos = v_p2 > 0;
v_2_neg = v_p2 < 0;
v_2_stat = v_p2 == 0;
eta_c2 = v_2_pos./eta_c + v_2_neg*eta_c + v_2_stat;


p_2 = p_2*ones(1,length(time));
p_1_cyl1 = (F_1./eta_c1 + p_2*A_r1)/(A_p1);
p_1_cyl2 = (p_2*A_r2 + F_2./eta_c2)/(A_p2);
p_1max_cyl1 = max(p_1_cyl1);
p_1max_cyl2 = max(p_1_cyl2);
p_min = max([p_1max_cyl1 p_1max_cyl2]) * ones(1,length(time));

figure(6);
plot(time,p_1_cyl1);
hold on
plot(time,p_1_cyl2);
plot(time,p_2);
plot(time,p_min);
plot(time,p_1max*ones(1,length(time)));
title("Pressure vs Time");
xlabel("Time (s)");
ylabel("Pressure (Pa)");
legend("P1 - Cylinder 1","P1 - Cylinder 2", "P2", "Minimum Pressure", "Maximum Pressure");
ylim([0 3e+07]);

% Task 3.b

q_1 = A_p1*abs(v_p1).*v_1_pos + A_r1*abs(v_p1).*v_1_neg;
q_2 = A_p2*abs(v_p2).*v_2_pos + A_r1*abs(v_p2).*v_2_neg;
q_tot = q_1 + q_2;
q_max = (max(q_tot)/q_rwc)*ones(1,length(time));

figure(7);
plot(time,q_1);
hold on
plot(time,q_2);
plot(time,q_tot);
plot(time,q_max);
title("Volumetric Flow vs Time");
ylabel("Volumetric Flow (m^3/s)");
xlabel("Time (s)");
legend("Cylinder 1","Cylinder 2","Total Flow","Maximum Flow");

% 4.b

V_gmax = 45e-6;
q_vmax = 135*60000;
n_nom = 3000;
delta_pmax = 315;
delt_pnom = 250;

% Task 5.a

p_pump = 13*ones(1,length(time));
figure(8);
plot(time,p_pump)
title("System Pressure through Time");
xlabel("Time (s)");
ylabel("Pump pressure (MPa)");
ylim([0 35]);

% Task 5.b

q_pump = q_tot;
figure(9);
plot(time,q_pump);
title("System Volumetric Flow through Time");
xlabel("Time (s)");
ylabel("Volumetric Flow (m^3/s)");

%5.c - Efficiencies

p_pump_mpa = p_pump*10^6;

n = 2500/60;
eps_p = (q_pump + V_gmax*c_v*p_pump_mpa/eta)./(V_gmax*n);
eta_vol = 1 - (c_v * p_pump_mpa)./(abs(eps_p)*n*eta);
eta_hm = 1 ./ (1 + (k_p + k_v*n*eta./p_pump_mpa) .* exp(k_eps.*(1-abs(eps_p))));
eta_t = eta_vol .* eta_hm;

figure(10);
plot(time,eps_p);
title("Pump Displacement Coefficienct through Time");
xlabel("Time (s)");
ylabel("Displacement Coefficient [-]");

figure(11);
plot(time,eta_vol);
hold on
plot(time,eta_hm);
plot(time,eta_tot);
title("System efficiencies through time");
xlabel("Time (s)");
ylabel("Efficiency [-]");
ylim([0 1]);
legend("Volumetric Efficiency","Hydro-mechanical efficiency","Total efficiency");