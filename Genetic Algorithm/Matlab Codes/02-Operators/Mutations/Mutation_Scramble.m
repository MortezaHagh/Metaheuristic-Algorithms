function y=Mutation_Scramble(x)

n=numel(x);
i=randsample(n,2);
i1=min(i(1),i(2));
i2=max(i(1),i(2));

m=i2-i1+1;
p=i1:i2;
q=p(randperm(m));

y=x;
y(p)=x(q);

end
