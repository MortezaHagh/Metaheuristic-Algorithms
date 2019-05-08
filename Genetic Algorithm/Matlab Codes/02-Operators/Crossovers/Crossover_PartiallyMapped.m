function [y1,y2]=Crossover_PartiallyMapped(x1,x2)

nVar=numel(x1);

% Offspring Number 1
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

sp1=zeros(1,nVar);
sp1(i1+1:i2)=x1(i1+1:i2);

temp1=x1(i1+1:i2);         % batch in parent 1
temp2=x2(i1+1:i2);         % corresponding batch in parent 2
sp2=setdiff(temp2,temp1);  % sp2 : Non-repetitive Nodes of batch 2 releative to batch 1

% temp4 : non-repetitive Nodes of x2 releative to common nodes of x1 & x2
b=intersect(x1,x2);  % common nodes of x1 & x2
temp4=setdiff(x2, b);

%%%
kk=1;
for i=1:length(sp2)
    
    a=x1(x2==sp2(i));     % a : (value) element of x1 with index of sp2(i) in x2
    if find(temp2==a)     % temp2 : batch 2
        while find(temp2==a)
            a=x1(x2==a);
        end
    end
    
    p=find(x2==a);  % index of element of x2 with value equal to a
    % if a is not a node in x2
    if isempty(p)
        a=temp4(kk);
        p=find(x2==a);
        kk=kk+1;
    end
    sp1(p)=sp2(i);
end

% temp3 : Members of x2 which are not in sp1
temp3=setdiff(x2,sp1);

aa=find(~sp1); % indices of sp1 whith no node
sp1(aa)=temp3(1:length(aa));
y1=sp1(1:nVar);

clear sp1 sp2 temp1 temp2 temp3 temp4 a aa b p

% Offspring Number 2
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

sp1=zeros(1,nVar);
sp1(i1+1:i2)=x2(i1+1:i2);

temp1=x2(i1+1:i2);
temp2=x1(i1+1:i2);
sp2=setdiff(temp2, temp1);

b=intersect(x1,x2);
temp4=setdiff(x1,b);

kk=1;
for i=1:length(sp2)
    
    a=x2(x1==sp2(i));
    
    if find(temp2==a)
        while find(temp2==a)
            a=x2(x1==a);
        end
    end
    
    p=find(x1==a);
    if isempty(p)
        a=temp4(kk);
        p=find(x1==a);
        kk=kk+1;
    end
    sp1(p)=sp2(i);
end

temp3=setdiff(x1, sp1);

aa=find(~sp1);
sp1(aa)=temp3(1:length(aa));
y2=sp1(1:nVar);

clear sp1 sp2 temp1 temp2 temp3 a aa

end
