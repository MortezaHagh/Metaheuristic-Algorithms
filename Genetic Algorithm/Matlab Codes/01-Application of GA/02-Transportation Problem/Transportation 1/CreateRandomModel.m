function model=CreateRandomModel(I,J)

% I: Customers  J: Producers

amin=10;
amax=90;
a=randi([amin, amax],1,I); %Demand

bmean=sum(a)/J;
bmin=round(bmean);
bmax=round(1.2*bmean);
b=randi([bmin bmax],1,J);  % Production

cmin=10;
cmax=50;
c=randi([cmin, cmax],I,J); % Costs

model.I=I;
model.J=J;
model.a=a;
model.b=b;
model.c=c;

end