clear, close all; 

d1 = 166.3e-3;
a2 = 221e-3;
a3 = 32.5e-3;
d4 = 235e-3;

% Posture desiree
L=0.1;  xf=0.1; yf=0.1; zf=0.05; 
T06d = [1,0,0,xf;0,-1,0,yf;0,0,-1,zf-L;0,0,0,1]; 
t14 = T06d(1,4); t24 = T06d(2,4); 

[X,Y,Z] = params_type2_O14_q1_(t14,t24); 
S = solve_type_2(X,Y,Z); 

tab_q1 = vars_type2_O14_q1_(S.Ai); 
for iq1 = 1:length(tab_q1)
    q1 = tab_q1(iq1)
    t34 = T06d(3,4); 
    [W1,W2,X,Y,Z1,Z2] = params_type6_O24_q2_q3_(a2,a3,d1,d4,q1,t14,t24,t34); % j ai une equation de type6 before 
    S1 = solve_type_7(W1,W2,X,Y,Z1,Z2); 
    
    [tab_q2,tab_q3] = vars_type7_O24_q2_q3_(S.Ai,S.Ak)
    for iq23 = 1:length(tab_q2)
        q2 = tab_q2(iq23);
        q3 = tab_q3(iq23);
        [T01,T12,T23,T34,T45,T56] = mgiNed2([q1;q2;q3;0;0;0],params);

        T03 = T01*T12*T23; 
        T30 = get_InvT(T03);
        T36d = T30*T06;
        t33 = T36d(3,3); 

        tab_q5 = vars_type2_T36_33_q5_(S.Ai)
        for iq5 = 1:length(tab_q2)
            q5 = tab_q5(iq5);
            [X,Y,Z] = params_type2_T36_33_q5_(t33)
            S3 = solve_type_2(X,Y,Z);

            tab_q6 = vars_type3_T35_q6_(S.Ai)
            for iq5 = 1:length(tab_q2)
                q6 = tab_q5(iq6);
                [X1,Y1,Z1,X2,Y2,Z2] = params_type3_T35_q6_(t31,t32,t34); 
                S4 = solve_type_3(X1,Y1,Z1,X2,Y2,Z2);

                tab_q4 = vars_type3_T46_13_q4_(S.Ai); 
                for iq4 = 1:length(tab_q4)
                    [X1,Y1,Z1,X2,Y2,Z2] = params_type3_T46_13_q4_(t14,t24); 
                    % S5 = solve_type_3
                end 
            end 
        end 
    end 
end 
  %q4
        T46 =T45*T56; 
        [X1,Y1,Z1,X2,Y2,Z2] = params_type3_T46_13_q4_(t14,t24)
        S4 = solve_type_3(X1,Y1,Z1,X2,Y2,Z2)
        tab_q4 = vars_type3_T46_13_q4_(S.Ai)

            
