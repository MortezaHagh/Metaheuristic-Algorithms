function [y1,y2]=Crossover_Order1(x1,x2)

nVar=numel(x1);
c=randi([1 nVar-1],[1,2]);
i1=min(c);
i2=max(c);

if i1==i2
    while i1==i2
        c=randi([1 nVar-1],[1,2]);
        i1=min(c);
        i2=max(c);
    end
end

% Offspring Number 1
sp1=x1(i1+1:i2);
sp2=setdiff(x2,sp1,'stable');
y1=[sp2(1:i1) sp1 sp2(i1+1:end)];
clear sp1 sp2

% Offspring Number 2
sp1=x2(i1+1:i2);
sp2=setdiff(x1,sp1,'stable');
y2=[sp2(1:i1) sp1 sp2(i1+1:end)];

end