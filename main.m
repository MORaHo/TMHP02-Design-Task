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
eta_c = 0.94;

% Constants and Time

g = 9.81;
time = linspace(0,t_0,length(e_1));

%De-normalise velocity

v_p1 = v_p0*v_p01;
v_p2 = v_p0*v_p02;

time = linspace(0,t_0,length(e_1));

% Task 1.a

figure(1);

plot(time,e_1);
hold on
plot(time,e_2);

legend("th_1","th_2")
xlabel("Time (s)")
ylabel("e1, e2 (m)")
title("e_1 vs Time & e_2 vs Time")

az = L_1 * sin(th_1);
ax = L_1 * cos(th_1);
bz = L_2 * sin(th_2) + az + 3;
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

F_wc_1 = max(M_tmax*g*(L_1*cos(th_1_wc_cyl1)+L_2*cos(th_2_wc_cyl1))./e_1);
F_wc_2 = max(M_tmax*g*L_2*cos(th_2_wc_cyl2)./e_2);

delta_p = P_smax-1000000;

D_1 = sqrt(4*F_wc_1/(pi*eta_c*delta_p)); %%0.1142 meters
D_2 = sqrt(4*F_wc_2/(pi*eta_c*delta_p)); %%0.077 meters

%{
I think we should consider a smaller area on the rod since, ad 0.5A_H
This would increase the required diameter, and would be more physically correct
The chosen cylinders would change but they exist so I should be fine
%}

close all

% Task 2.b

%{
https://www.boschrexroth.com/en/gb/p/hydraulic-cylinder-r900999033/ 
17 We've chosen a CGH3 type hydraulic cylinder with 125mm diameter for the first cylinder,
and an 80mm bore diameter CGH3 cylinder for the second cylinder.
%}

%{
I would calculate the area ratio just to make sure we are within the conditions
We can also check from the datasheet if we are below the maximum stroke velocity during the drive cycle
%}

v_max_1 = 0.14*ones(length(time),1);
v_max_2 = 0*ones(length(time),1); %don't know value yet

plot(time,v_max_1);
hold on
plot(time,v_p1);
plot(time,v_max_2);
plot(time,v_p2);
legend("Max Stroke Speed: Cylinder 1","Stroke Speed: Cylinder 1","Max Stroke Speed: Cylinder 2","Stroke Speed: Cylinder 2");


% Task 3.a