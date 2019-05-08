function model=CreateRandomModel(I,J)

% I: Customers  J: Producers

amin=10;
amax=90;
a=randi([amin, amax],1,I); % Demand

bmax=round(2*sum(a));      % Production

cmin=10;
cmax=50;
c=randi([cmin, cmax],I,J); % Costs

e0=1000;
e1=50;

model.I=I;
model.J=J;
model.a=a;
model.bmax=bmax;
model.c=c;
model.e0=e0;
model.e1=e1;

end