% Designing pid controller with root locus method for ball and beam system.
clear
clc
close all

g = 9.8;
kb = 5*g/7;
% generate plant model
GP_num = kb;
GP_den = [1 0 0];

% Proportional Integral Derivate controller
% zero steady state erroe
% robust to external disturbances

GP = tf(GP_num, GP_den); % G of plant
controlSystemDesigner(GP);

