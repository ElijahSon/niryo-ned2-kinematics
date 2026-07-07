clear all; close all;
d1=166.3e-3;
a2=221e-3;
a3=32.5e-3;
d4=235e-3;
params=[d1;a2;a3;d4];
L=0.1;
tab_q=zeros(6,0);
%posture desiree
xf=0.1;yf=0.1;zf=0.05;
T06d=[1,0,0,xf;0,-1,0,yf;0,0,-1,zf+L;0,0,0,1]; 
 q=rand(6,1);
 [T01,T12,T23,T34,T45,T56] = mgdNed2(q,params);
T06d=T01*T12*T23*T34*T45*T56;

t14=T06d(1,4);t24=T06d(2,4);
[X,Y,Z] = params_type2_O14_q1_(t14,t24);
S=solve_type_2(X,Y,Z);
tab_q1 = vars_type2_O14_q1_(S.Ai)
for iq1=1:length(tab_q1)
  q1=tab_q1(iq1);
  t34=T06d(3,4);
   [W1,W2,X,Y,Z1,Z2] = params_type7_O24_q2_q3_(a2,a3,d1,d4,q1,t14,t24,t34);
   S=solve_type_7(W1,W2,X,Y,Z1,Z2);
   [tab_q2,tab_q3] = vars_type7_O24_q2_q3_(S.Ai,S.Ak);
   for iq23=1:length(tab_q2)
     q2=tab_q2(iq23);
     q3=tab_q3(iq23);
     [T01,T12,T23,T34,T45,T56] = mgdNed2([q1;q2;q3;0;0;0],params);
     T03=T01*T12*T23; 
     T30=get_InvT(T03);
     T36d=T30*T06d;
     t33=T36d(3,3);
     % determination de q5 
     [X,Y,Z] = params_type2_T36_33_q5_(t33);
      S=solve_type_2(X,Y,Z);
      tab_q5 = vars_type2_T36_33_q5_(S.Ai);
      for iq5=1:length(tab_q5)
          q5=tab_q5(iq5);
          t31=T36d(3,1);t32=T36d(3,2);
          [X1,Y1,Z1,X2,Y2,Z2] = params_type3_T35_3_12_q6_(q5,t31,t32);
          S=solve_type_3(X1,Y1,Z1,X2,Y2,Z2);
          tab_q6=vars_type3_T35_3_12_q6_(S.Ai);
          for iq6=1:length(tab_q6)
              q6=tab_q6(iq6);
               t11=T36d(1,1);t12=T36d(1,2);t21=T36d(2,1);t22=T36d(2,2);
              [X1,Y1,Z1,X2,Y2,Z2] = params_type3_T46_3_12_q4_(q6,t11,t12,t21,t22);
              S=solve_type_3(X1,Y1,Z1,X2,Y2,Z2);
              tab_q4=vars_type3_T46_3_12_q4_(S.Ai);
              %[X,Y,Z] = params_type2_T46_3_1_q4_(q6,t11,t21);
              %S=solve_type_2(X,Y,Z);
              %tab_q4=vars_type3_T46_3_1_q4_(S.Ai);
              for iq4=1:length(tab_q4)
                 q4=tab_q4(iq4);
                 q=[q1;q2;q3;q4;q5;q6];
                 tab_q=[tab_q,q];
              end    
               
          end
      end    
   end 
end
% VERIFICATION
[~,ns]=size(tab_q);
for iq=1:ns,
   q=tab_q(:,iq);
   [T01,T12,T23,T34,T45,T56] = mgdNed2(q,params);
  T06=T01*T12*T23*T34*T45*T56;
  err=T06d-T06;
  err=max(abs(err(:)))
end    
    
    

