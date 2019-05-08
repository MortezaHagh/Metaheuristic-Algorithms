function [o1, o2]=Crossover(i1, i2, gama, VarMin, VarMax)

alpha=unifrnd(-gama,1+gama,size(i1.x));

%%% x
x1=i1.x;
x2=i2.x;

y1=x1.*alpha+x2.*(1-alpha);
y2=x2.*alpha+x1.*(1-alpha);

y1=max(y1, VarMin.x);
y1=min(y1, VarMax.x);

y2=max(y2, VarMin.x);
y2=min(y2, VarMax.x);

o1.x=y1;
o2.x=y2;

%%% y
x1=i1.y;
x2=i2.y;

y1=x1.*alpha+x2.*(1-alpha);
y2=x2.*alpha+x1.*(1-alpha);

y1=max(y1, VarMin.y);
y1=min(y1, VarMax.y);

y2=max(y2, VarMin.y);
y2=min(y2, VarMax.y);

o1.y=y1;
o2.y=y2;

end