function y=Mutation(x)

M=randi([1 4]);

switch M
    case 1
        y=Mutation_Swap(x);
    case 2
        y=Mutation_Reversion(x);
    case 3
        y=Mutation_Insertion(x);
    case 4
        y=Mutation_Scramble(x);
end

end

function y=Mutation_Swap(x)

n=numel(x);
i=randsample(n,2);
i1=i(1);
i2=i(2);

y=x;
y([i1 i2])=x([i2 i1]);

end

function y=Mutation_Reversion(x)

n=numel(x);
i=randsample(n,2);
i1=min(i(1),i(2));
i2=max(i(1),i(2));

y=x;
y(i1:i2)=x(i2:-1:i1);

end

function y=Mutation_Insertion(x)

n=numel(x);
i=randsample(n,2);
i1=i(1);
i2=i(2);

if i1<i2
    y=x([1:i1-1 i1+1:i2 i1 i2+1:end]);
end

if i1>i2
    y=x([1:i2 i1 i2+1:i1-1 i1+1:end]);
end

end

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
