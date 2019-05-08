function model=CreateModel()

% Process Times
p=[14 45 14 24 34 10 38 11 57 59 29 10 32 45 28 54 50 30 43 36];

% Setup Time
s =[17,16,13,11,10,14,20,13,15,17,10,19,15,19,15,12,18,20,10,12
    17,16,11,20,12,11,15,13,15,10,13,11,20,13,16,13,11,14,15,20
    13,18,16,19,20,10,14,15,12,18,12,12,11,19,19,18,12,17,18,18
    19,10,12,13,12,16,14,20,14,19,17,19,17,16,13,18,13,14,10,16
    16,14,18,12,14,10,13,15,13,16,14,15,17,20,14,17,20,12,16,19
    14,13,18,13,19,19,19,17,11,17,14,13,16,20,15,17,20,15,19,15
    15,17,13,19,18,15,18,19,20,13,17,18,12,10,14,18,10,10,11,14
    17,16,11,18,13,17,16,11,15,18,12,14,16,12,15,10,18,13,15,16
    18,11,19,16,10,18,13,17,18,11,17,19,10,12,18,10,16,17,12,12
    17,19,14,19,11,17,17,11,19,16,12,15,14,20,14,19,19,17,12,15
    14,16,18,10,18,12,10,12,18,15,18,17,10,15,14,17,14,17,14,19
    17,12,13,14,10,19,13,17,13,15,15,16,12,11,19,13,14,16,19,10
    20,10,11,20,17,18,19,12,18,13,17,15,10,19,12,10,12,15,20,17
    17,20,15,18,16,18,11,14,19,10,11,13,15,20,20,10,11,11,14,13
    13,13,12,12,10,19,20,20,20,19,10,17,11,16,15,11,16,18,15,15
    18,20,10,16,14,11,15,16,13,17,18,18,12,15,17,18,14,10,16,20
    19,13,19,17,17,18,19,15,20,16,15,17,17,12,11,13,12,14,10,20
    18,15,15,16,13,19,18,13,17,11,18,12,10,11,14,12,17,20,16,10
    15,18,13,11,12,20,14,14,15,12,13,17,13,19,17,20,15,14,18,14
    19,17,17,20,13,12,11,11,10,14,13,15,14,17,17,16,15,17,13,10];

% Delivery time
d=[360 477 1438 1304 329 936 1385 685 488 431 505 1454 427 922 576 1034 262 884 1173 433];

n=numel(p);

% Cost Weight Coefficients
w1=1;
w2=1;

model.n=n;
model.p=p;
model.d=d;
model.s=s;
model.w1=w1;
model.w2=w2;

end