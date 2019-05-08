function y=PermutationMutate(x)

M=randi([1 3]);

switch M
    case 1
        y=DoSwap(x);
    case 2
        y=DoReversion(x);
    case 3
        y=DoInsertion(x);
end

end

function y=DoSwap(x)

n=numel(x);
i=randsample(n,2);
i1=i(1);
i2=i(2);

y=x;
y([i1 i2])=x([i2 i1]);

end

function y=DoReversion(x)

n=numel(x);
i=randsample(n,2);
i1=min(i(1),i(2));
i2=max(i(1),i(2));

y=x;
y(i1:i2)=x(i2:-1:i1);

end

function y=DoInsertion(x)

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
