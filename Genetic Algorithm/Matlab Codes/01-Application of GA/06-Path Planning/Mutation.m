function o=Mutation(i, mu, VarMin, VarMax)

nVar=numel(i.x);
nmu=ceil(mu*nVar);
j=randsample(nVar,nmu);

%%% x
x=i.x;
sigma=0.1*(VarMax.x-VarMin.x);
y=x;
y(j)=x(j)+sigma*randn(size(j));

y=max(y, VarMin.x);
y=min(y, VarMax.x);

o.x=y;

%%% y
x=i.y;
sigma=0.1*(VarMax.y-VarMin.y);
y=x;
y(j)=x(j)+sigma*randn(size(j));

y=max(y, VarMin.y);
y=min(y, VarMax.y);

o.y=y;

end