clear ; close all; clc;
addpath('tr_homogene\');
addpath('equations_de_paul\');
Pi=sym(pi);
syms q1 q2 q3 q4 q5 q6;
syms d1 a2 a3 d4;
params=[d1;a2;a3;d4];
q=[q1;q2;q3;q4;q5;q6]; nq=length(q);

T01=get_dh(q1        ,d1,0 , Pi/2  );T10=simplify(get_InvT(T01));
T12=get_dh(q2+Pi/2,0  ,a2, 0     );T21=simplify(get_InvT(T12));
T23=get_dh(q3        ,0  ,a3, Pi/2 );T32=simplify(get_InvT(T23));
T34=get_dh(q4        ,d4,0  ,-Pi/2 );T43=simplify(get_InvT(T34));
T45=get_dh(q5        ,0  ,0  , Pi/2 );T54=simplify(get_InvT(T45));
T56=get_dh(q6        ,0  ,0  , 0     );T65=simplify(get_InvT(T56));
T06=simplify(T01*T12*T23*T34*T45*T56);
matlabFunction(T01,T12,T23,T34,T45,T56,'File','mgdNed2.m','vars',{q;params});
matlabFunction(T06,'File','T06Ned2.m','vars',{q;params});
%-----------------------------------------------------------------------------
% posture desiree T06d
%-----------------------------------------------------------------------------
syms t11 t12 t13 t14 t21 t22 t23 t24 t31 t32 t33 t34;
T06d=[t11,t12,t13,t14;t21,t22,t23,t24; t31, t32, t33 ,t34;0,0,0,1];
%---------------------------------------------------------------------------------------------
% intuition 1: O4d ne depend pas des qi , mais uniquement de 0T6d
%--------------------------------------------------------------------------------------------
T04d=T06d*T65*T54;
O04d=T04d(1:3,4);

%---------------------------------------------------------------------------------------------
% intuition 2: 0O4 ne depend que de q1,q2 ,q3 , PAS de q4
%---------------------------------------------------------------------------------

T04=T01*T12*T23*T34;
O04=T04(1:3,4);

%---------------------------------------------------------------------------------
% intuition 3: composante suivant z1 de 1O4 est =0 !!
%---------------------------------------------------------------------------------

T14=T12*T23*T34;
O14=simplify(T14(1:3,4));
O14d   = T10(1:3,:)*[O04d;1];                % forcement fct de q1 car O04 ne depend d'aucun qi
errO14=O14d-O14;
equation_q1=identif_equ_paul(q1,errO14(3),'O14_q1');
%---------------------------------------------------------------------------------
% on separe q2 et q3 en ecrivant meme chose dans rep 2 : (q1 est connu )
%---------------------------------------------------------------------------------
T24=T23*T34;
O24=simplify(T24(1:3,4));
T20=T21*T10;
O24d   = T20(1:3,:)*[O04d;1];                % forcement fct de q1 car O04 ne depend d'aucun qi
errO24=O24d-O24;
equation_q2_q3=identif_equ_paul([q2,q3],errO24(1:2),'O24_q2_q3');
%-------------------------------------------------------------------------------
% equations d'orient taion : 3T6d = 3T6(q4,q5,q6)
% en vrai 3T6d = 3T0(q1,q2,q3) * 0T6d, mais on l'ecrira uniquement dans le
% prog numerique
%--------------------------------------------------------------------------------------------------------
T36d=[t11,t12,t13,t14;t21,t22,t23,t24; t31, t32, t33 ,t34;0,0,0,1];
T36=T34*T45*T56;

errT36=T36d-T36;
equation_q5=identif_equ_paul([q5],errT36(3,3).','T36_33_q5');

T46d=T43*T36d;
T46=T45*T56;
errT46=T46d-T46

T35d=T36d*T65;
T35=T34*T45;
errT35=T35d-T35
equation_q6=identif_equ_paul([q6],errT35(3,1:2),'T35_3_12_q6')
equation_q4=identif_equ_paul([q4],errT46(3,1:2),'T46_3_12_q4')
equation_q4=identif_equ_paul([q4],errT46(3,1),'T46_3_1_q4')


