clear, close all; 

% exercice transformation homogene 
syms LX LY LZ yaw pitch roll G wG 

% Repere monde vers le repere portable 
wTp = trans(LX,LY,LY)*th_rotz_theta(yaw)*th_roty_theta(pitch)*th_rotx_theta(roll); 
disp(wTp)

% coordonnées du vecteur G dans le repere monde 
wG = [0
      0
      G];
% coordonnées du vecteur G dans le repere portable  
pG = wTp(1:3,:)*[wG;0] ; 
disp(pG)
% méthode permettant de retrouver les 2 angles pitch et roll
% roll = ;
