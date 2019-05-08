function y=Mutation(x, mu)

% Bit Flip Mutation
nVar=numel(x);
nmu=ceil(mu*nVar);
j=randsample(nVar,nmu);

y=x;
y(j)=1-x(j);

end