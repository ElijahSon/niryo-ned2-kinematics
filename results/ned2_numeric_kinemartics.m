clear, close all; 
addpath('tr_homogene')
addpath('equations_de_paul')

d1=166.3e-3;
a2=221e-3;
a3=32.5e-3;
d4=235e-3;
params=[d1;a2;a3;d4];

q = rand(6,1)*2*pi; 

% -------------------------------------------------------------------------
% employer la jacobienne en position pour que le point de coordonnees 
% [0.01,0.1,0.02] dans le repere 6 se deplace de 1cm le long de l axe x du
% repere 0
% -------------------------------------------------------------------------

P6 = [0.01;0.1;0.02]; % en m  
J0P6 = J0P6Ned2(q,params,P6)
T06 = T06Ned2(q,params)
P06 = T06(1:3,:)*[P6;1];
dP06 = [0.01;0;0]; 
dq = pinv(J0P6)*dP06; 

T06f = T06Ned2(q+dq,params)
P06f = T06f(1:3,:)*[P6;1];
deltaP = P06f - P06 % verification du resultat --> erreur 

% -------------------------------------------------------------------------
% 1- on calcule P06(q)
% 2- on calcule dq avec J 
% 3- on calcule P06(d+dq)
% 4- on en deduit le deplacement 
% -------------------------------------------------------------------------
% employer la jacobienne en orientation pour  que l orientation du repre
% 6/R0 corresponde a une rotation de 10 degres autour de x0 
% -------------------------------------------------------------------------
