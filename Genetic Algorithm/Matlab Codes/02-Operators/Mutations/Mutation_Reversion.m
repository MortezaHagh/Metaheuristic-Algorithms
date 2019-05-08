function y=Mutation_Reversion(x)

n=numel(x);
i=randsample(n,2);
i1=min(i(1),i(2));
i2=max(i(1),i(2));

y=x;
y(i1:i2)=x(i2:-1:i1);

end