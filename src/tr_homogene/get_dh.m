%--------------------------------------------------------------
% transformation de denavit hartenberg
%--------------------------------------------------------------
  function iTk=get_dh(theta,d,a,alpha)
    iTk=get_rot_z(theta)*get_trans(a,0,d)*get_rot_x(alpha);
  end