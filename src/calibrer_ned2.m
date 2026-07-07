clear, close all; 

% declaratioin de variables symboliques
syms q1 q2 q3 q4 q5 q6 d1 d2 d3 d4 d5 d6 a2 a3 real 
pi = sym(pi) ;

% Transformations homogenes du repere 0 au repere 6 
r0Tr1 = simplify(th_dh(q1,0,d1,pi/2));
r1Tr2 = simplify(th_dh(q2+pi/2,a2,0,0));
r2Tr3 = simplify(th_dh(q3,a3,0,pi/2));
r3Tr4 = simplify(th_dh(q4,0,d4,-pi/2));
r4Tr5 = simplify(th_dh(q5,0,0,pi/2));
r5Tr6 = simplify(th_dh(q6,0,0,0));

% chqngement de repere de 0 à 6
ned_opt_track_0t6 = simplify(r0Tr1*r1Tr2*r2Tr3*r3Tr4*r4Tr5*r5Tr6);
% ned_opt_track_6t0 = simplify(inv(ned_opt_track_0t6))

q = [q1
     q2
     q3
     q4
     q5
     q6];
 
 qv = sym(zeros(6,1));
 
 
 %% 
T06v = subs(ned_opt_track_0t6,q,qv);
 
ned_opt_track_0t5 = simplify(r0Tr1*r1Tr2*r2Tr3*r3Tr4*r4Tr5);
T05v = subs(ned_opt_track_0t5,q,qv);

ned_opt_track_0t4 = simplify(r0Tr1*r1Tr2*r2Tr3*r3Tr4);
T04v = subs(ned_opt_track_0t4,q,qv);

ned_opt_track_0t3 = simplify(r0Tr1*r1Tr2*r2Tr3);
T03v = subs(ned_opt_track_0t3,q,qv);

ned_opt_track_0t2 = simplify(r0Tr1*r1Tr2);
T02v = subs(ned_opt_track_0t2,q,qv);

ned_opt_track_0t1 = simplify(r0Tr1);
T01v = subs(ned_opt_track_0t1,q,qv);

% T05v = T06v car ils ont tous deux l axe Oz5 en commun donc oz5 = Oz6 

% Coordonnees de la bille dans le repere 0 sachant ses coordonnes
% symboliques dans le repere 6 
syms x6 y6 z6 d1 real 

ned6bille = [x6
             0
             z6];
   
ned0bille = T06v(1:3,:)*[ned6bille;1]; % coordonnees de la bille dans le repere du robot ned 

f = ned0bille ; 
H = jacobian(f,[x6;y6;z6;d1]);
Y = subs(f,[x6;y6;z6;d1],[0;0;0;0]);
Ywith1 = subs(f,[x6;y6;z6;d1],[0;0;0;1]);

%% 
% definition de la matrice nedTOptitrack 
syms t11 t12 t13 t14 t21 t22 t23 t24 t31 t32 t33 t34 real 
syms x y z real 
nedTOptitrack = [t11 t12 t13 t14 
                 t21 t22 t23 t24
                 t31 t32 t33 t34
                 0   0   0   1  ];

optitrackBille = [x
                  y
                  z];
              
nedBille = nedTOptitrack*[optitrackBille ;1]; 
H1 = jacobian(nedBille(1:3,1),[t11;t12;t13;t14;t21;t22;t23;t24;t31;t32;t33;t34;x6;y6;z6]);
% Yopt1 = subs(nedBille,[t11;t12;t13;t14;t21;t22;t23;t24;t31;t32;t33;t34;x6;y6;z6],zeros(15,1))

err = nedBille(1:3,1) - ned0bille ;
Y1 = subs(err,[t11;t12;t13;t14;t21;t22;t23;t24;t31;t32;t33;t34;x6;y6;z6],zeros(15,1));

matlabFunction(H1,Y1,'File','CalcHF','vars',[x,y,z,q1,q2,q3,q4,q5,q6,d1,d2,d3,d4,d5,d6,a2,a3])



       
       
       
       
