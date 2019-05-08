function ysol=Mutation(xsol,mu)

q=randi([1 7]);

ysol=xsol;

if any(q ==[1,4,5,7])
    % Apply Mutation to f (Binary)
    ysol.f=BinaryMutation(xsol.f, mu);
end

if any(q==[2,4,6,7])
    % Apply Mutation to xhat (Real)
    ysol.xhat=RealMutation(xsol.xhat,mu);
end

if any(q==[3,5,6,7])
    % Apply Mutation to bhat (Real)
    ysol.bhat=RealMutation(xsol.bhat,mu);
end

end

function y=RealMutation(x,mu)

VarMin=0;
VarMax=1;

nVar=numel(x);
nmu=ceil(mu*nVar);
j=randsample(nVar,nmu);

sigma=0.1*(VarMax-VarMin);

y=x;
y(j)=x(j)+sigma*randn(size(j));

y=max(y,VarMin);
y=min(y,VarMax);

end

function y=BinaryMutation(x,mu)

nVar=numel(x);
nmu=ceil(mu*nVar);
j=randsample(nVar,nmu);

y=x;
y(j)=1-x(j);

end