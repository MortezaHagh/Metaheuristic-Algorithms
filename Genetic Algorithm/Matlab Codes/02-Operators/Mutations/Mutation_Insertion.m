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