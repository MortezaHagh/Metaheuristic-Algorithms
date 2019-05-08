function ysol=Mutation(xsol,mu)

q=randi([1 3]);

ysol=xsol;

if q==1 || q==2
    % Apply Mutation to f (Binary)
    ysol.f=BinaryMutation(xsol.f, mu);
end

if q==2 || q==3
    % Apply Mutation to xhat (Real)
    ysol.xhat=RealMutation(xsol.xhat,mu);
end

end


function y=BinaryMutation(x,mu)

nVar=numel(x);
nmu=ceil(mu*nVar);
j=randsample(nVar,nmu);

y=x;
y(j)=1-x(j);

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
