% Partie numerique du probleme 
data=load('niryo_calibration_data.txt','ASCII');

k=find(data(:,1)==1);

data=data(k,:);
segment=data(:,2);

t=data(:,3); % matriceNX1 des instants d'acquisition des pointsi=1..N
x=data(:,4);% matrice NX1 = coord x optitrack des points i=1..N
y=data(:,5);% matrice NX1 = coord y optitrack des points i=1..N
z=data(:,6);% matrice NX1 = coord z optitrack des points i=1..N
joints=data(:,7:end);% matriceNX6 des degres de liberte [q1i,..q6i] des points i=1..N

q1 = joints(:,1)
q2 = joints(:,2)
q3 = joints(:,3)
q4 = joints(:,4)
q5 = joints(:,5)
q6 = joints(:,6)

N = 64

H=[];Y=[];

for i=1:N
    
    [Hi,Yi] = CalcHF(x,y,z,q1,q2,q3,q4,q5,q6); 
    H=[H;Hi];Y=[Y;Yi];

end
    X = -pinv(H)*Y; 
    err = H*X+Y % H=[H1;H2;..;HN], Y=[Y1;...;YN]
