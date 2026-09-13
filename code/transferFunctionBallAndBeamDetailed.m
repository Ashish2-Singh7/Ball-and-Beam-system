%% ball_beam_tf.m
% Linearized transfer function of a ball-and-beam system
% Plant relation: X(s)/Theta(s), derived from small-angle linearization
%
%   (m + J/R^2) * xddot = m*g*theta      (linearized ODE)
%   G(s) = X(s)/Theta(s) = (m*g) / [(m + J/R^2) * s^2]

clear; clc; close all;

%% ---- Physical parameters ----
g   = 9.81;         % gravity [m/s^2]
m   = 0.11;         % ball mass [kg]      (edit to your hardware)
R   = 0.02;         % ball radius [m]
k   = 2/5;          % moment-of-inertia factor: solid sphere = 2/5, hollow sphere = 2/3
J   = k * m * R^2;  % ball moment of inertia [kg*m^2]

%% ---- Linearized gain ----
% (m + J/R^2) xddot = m g theta  ->  xddot = [ m g / (m + J/R^2) ] theta
denom_mass = m + J/R^2;          % = m*(1+k)
K = (m * g) / denom_mass;        % = g/(1+k)   -> ball radius/mass cancel out
fprintf('Effective gain K = g/(1+k) = %.4f  (solid sphere k=2/5 -> K = 5g/7 = %.4f)\n', K, 5*g/7);

%% ---- Build transfer function G(s) = X(s)/Theta(s) = K / s^2 ----
s = tf('s');
G = K / s^2;
disp('Ball-and-beam transfer function G(s) = X(s)/Theta(s):');
G

%% ---- Equivalent state-space form ----
% states: [x; xdot],  input: theta,  output: x
A = [0 1; 0 0];
B = [0; K];
C = [1 0];
D = 0;
sys_ss = ss(A,B,C,D);
disp('Equivalent state-space model:');
sys_ss

%% ---- Open-loop analysis ----
figure('Name','Open-loop step response');
step(G, 3);
grid on;
title('Open-loop step response: \theta \rightarrow x (unstable double integrator)');
xlabel('Time (s)'); ylabel('Ball position x (m)');

figure('Name','Pole-zero map');
pzmap(G);
grid on;
title('Poles of G(s) = K/s^2 (double pole at origin)');

figure('Name','Bode plot');
bode(G);
grid on;
title('Open-loop Bode plot');

%% ---- Optional: quick PD/PID stabilizing controller for reference ----
% Because G(s) = K/s^2 is marginally stable (double pole at origin),
% pure proportional control cannot stabilize it -> derivative action is required.
Kp = 15;
Kd = 8;
C_pd = pid(Kp, 0, Kd);
T_closed = feedback(C_pd*G, 1);

figure('Name','Closed-loop step response with PD controller');
step(T_closed, 3);
grid on;
title(sprintf('Closed-loop step response (Kp=%.1f, Kd=%.1f)', Kp, Kd));
xlabel('Time (s)'); ylabel('Ball position x (m)');

fprintf('\nClosed-loop poles:\n');
disp(pole(T_closed));
