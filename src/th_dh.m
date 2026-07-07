 function iTj = th_dh(thetai,ai,di,alphai)
 
 iTj = th_rotz_theta(thetai)*trans(thetai,0,di)*th_rotx_theta(alphai); 
 
 end 
 
 