%% Rotation autour de l'axe z
% cercle de rayon unite, donc tous les vecteurs sont de norme =1
function iTk = th_rotz_theta(theta)
% syms theta 

c = cos(theta) ; 
s = sin(theta) ; 

iTk = [1    0   0   0
       0    c   -s  0
       0    s    c  0
       0    0   0   1];    
end 