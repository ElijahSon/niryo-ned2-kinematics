function [H,Y] = CalcHandF(x,y,z,q1,q2,q3,q4,q5,q6,d1,d2,d3,d4,d5,d6,a1,a2,a3,a4,a5,a6)
    
    H = jacobian([x;y;z],[q1,q2,q3,q4,q5,q6,d1,d2,d3,d4,d5,d6,a1,a2,a3,a4,a5,a6]');
    Y = subs(,[q1,q2,q3,q4,q5,q6,d1,d2,d3,d4,d5,d6,a1,a2,a3,a4,a5,a6],zeros(15,1));
    X = piv(H)*Y; 
    err = H*X + Y; 

end 