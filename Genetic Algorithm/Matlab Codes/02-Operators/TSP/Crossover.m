function [y1, y2]=Crossover(x1,x2)

M=randi([1 7]);
% M=7;

switch M
    case 1
        [y1, y2]=Crossover_SPX_Permutation(x1,x2);
    case 2
        [y1,y2]=Crossover_Order1(x1,x2);
    case 3
        [y1,y2]=Crossover_EdgeRecombination(x1,x2);
    case 4
        [y1,y2]=Crossover_PartiallyMapped(x1,x2);
    case 5
        X=[x1; x2];
        [y1,y2]=Crossover_MultiParent(X);
    case 6
        [y1, y2]=Crossover_Cycle(x1, x2);
    case 7
        [y1,y2]=Crossover_nOrder(x1,x2);
end

end

function [y1, y2]=Crossover_SPX_Permutation(x1,x2)

nVar=numel(x1);
c=randi([1 nVar-1]);

x11=x1(1:c);
x12=x1(c+1:end);

x21=x2(1:c);
x22=x2(c+1:end);

r1=intersect(x11,x22);
r2=intersect(x21,x12);

x11(ismember(x11,r1))=r2;
x21(ismember(x21,r2))=r1;

y1=[x11 x22];
y2=[x21 x12];

end

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

function [y1,y2]=Crossover_EdgeRecombination(x1,x2)

uni=union(x1,x2);
n=numel(uni);

% Neighbor List Table
Table=zeros(n,4);

for i=1:n
    
    % temp2 : x1 & x2 indices with value uni(i), if not exist put zero
    temp2(1)=find(x1==uni(i));
    temp2(2)=find(x2==uni(i));
    
    
    % temp3 : indices of uni(i) neighbors in x1
    if temp2(1)==1
        temp3=[n 2];
    elseif temp2(1)==n
        temp3=[n-1 1];
    else
        temp3=[temp2(1)-1 temp2(1)+1];
    end
    
    % temp4 : indices of uni(i) neighbors in x2
    if temp2(2)==1
        temp4=[n 2];
    elseif  temp2(2)==n
        temp4=[n-1 1];
    else
        temp4=[temp2(2)-1 temp2(2)+1];
    end
    
    temp5=union(x1(temp3),x2(temp4)); % Union of neighbors
    Table(i,1:length(temp5))=temp5;
    
end

clear temp2 temp3 temp4 temp5
Table2=Table;

% Offspring Number 1
sp1=zeros(1,n);
sp1(1)=uni(1);

kk=2;
while kk<=n
    clear temp2 temp3
    % remove chosen node [sp1(kk-1)] from neighbor list
    Table(Table==sp1(kk-1))=0;
    
    %%% Determine neighbor of Chosen Node [sp1(kk-1)] that has fewest neighbors
    
    % temp2 : neighbors of Chosen Node [sp1(kk-1)]
    temp2=Table(uni==sp1(kk-1), Table(uni==sp1(kk-1),:)~=0);
    
    % if there is no neighbor
    if isempty(temp2)
        temppp=setdiff(uni,sp1(1:kk-1));
        if numel(temppp)>1
            sp1(kk)=randsample(temppp,1);
        else
            sp1(kk)=temppp;
        end
        kk=kk+1;
    else
        % Length of neighbors of Chosen Node [sp1(kk-1)]
        for j=1:length(temp2)
            temp3(j)=length(find(Table(uni==temp2(j),:)~=0));
        end
        
        % Find neighbor with fewest neighbors
        [~,indx]=sort(temp3);
        sp1(kk)=temp2(indx(1));
        kk=kk+1;
    end
end
y1=sp1;

% Offspring Number 2
sp2=zeros(1,n);
sp2(1)=randsample(uni,1);
Table=Table2;

kk=2;
while kk<=n
    clear temp2 temp3
    Table(Table==sp2(kk-1))=0;
    temp2=Table(uni==sp2(kk-1),Table(uni==sp2(kk-1),:)~=0);
    if isempty(temp2)
        temppp=setdiff(uni,sp2(1:kk-1));
        if numel(temppp)>1
            sp2(kk)=randsample(temppp,1);
        else
            sp2(kk)=temppp;
        end
        kk=kk+1;
    else
        for j=1:length(temp2)
            temp3(j)=length(find(Table(uni==temp2(j),:)~=0));
        end
        [~,indx]=sort(temp3);
        sp2(kk)=temp2(indx(1));
        kk=kk+1;
    end
end

y2=sp2;

end

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

%%%
for i=1:length(sp2)
    
    a=x1(x2==sp2(i));     % a : (value) element of x1 with index of sp2(i) in x2
    if find(temp2==a)     % temp2 : batch 2
        while find(temp2==a)
            a=x1(x2==a);
        end
    end
    
    p= x2==a;  % index of element of x2 with value equal to a
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

for i=1:length(sp2)
    
    a=x2(x1==sp2(i));
    
    if find(temp2==a)
        while find(temp2==a)
            a=x2(x1==a);
        end
    end
    
    p= x1==a;
    sp1(p)=sp2(i);
end

temp3=setdiff(x1, sp1);

aa=find(~sp1);
sp1(aa)=temp3(1:length(aa));
y2=sp1(1:nVar);

clear sp1 sp2 temp1 temp2 temp3 a aa

end

function [y1,y2]=Crossover_MultiParent(X)

n=numel(X(1,:));  %% chromosome length

%%% uni : combined data from Input Paths with no repetitions
uni=union(X(1,:),X(2,:));

%%% D : Desirability Matrix
% D(j,i) : How may times uni(i) is repeated in j'th column of X Matrix
D=zeros(n,n);
for i=1:n      % length(uni)
    for j=n
        D(j,i)=length(find(X(:,j)==uni(i)));
    end
end
epsilon=0.0005*rand(n,n);
D=D+epsilon;

%%% Offsprings
sp=zeros(2,n);
for ss=1:2
    
    temp1=randperm(n,n);
    temp2=uni(temp1); % uni with new permutation
    
    for j=1:n
        [~,temp3]=sort(D(temp2(j),:),'descend');
        temp4=temp3(1);
        
        if ~isempty(find(sp(ss,:)==temp4, 1))
            k=2;
            while ~isempty(find(sp(ss,:)==temp4, 1))
                temp4=temp3(k);
                k=k+1;
            end
        end
        
        sp(ss,temp2(j))=temp4;
    end
    clear temp1 temp2 temp3 temp4 i j k
end

y1=sp(1,:);
y2=sp(2,:);

end

function [y1, y2]=Crossover_Cycle(x1, x2)

n=numel(x1);
y1=zeros(1,n);
y2=zeros(1,n);

cycles=cell(1,1);
tempCycle=[];
i=1;        % index of clue
num_cyc=0;  % num of cycles

while ~isempty(i)
    Cyc=i;
    clue=x1(i);
    x2_val=x2(i);
    while clue~=x2_val
        [~, x1_ind]=find(x1==x2_val);
        x2_val=x2(x1_ind);
        Cyc=[Cyc x1_ind];       %#ok
    end
    num_cyc=num_cyc+1;
    cycles{1,num_cyc}=Cyc;
    tempCycle=[tempCycle Cyc];  %#ok
    
    temp=setdiff(x1, tempCycle);
    [i, ~]=min(temp);
    
end

for j=1:2:num_cyc
    y1(cycles{1,j})=x1(cycles{1,j});
    y2(cycles{1,j})=x2(cycles{1,j});
    
    if (j+1)<=num_cyc
        y1(cycles{1,j+1})=x2(cycles{1,j+1});
        y2(cycles{1,j+1})=x1(cycles{1,j+1});
    end
    
end

end

function [y1,y2]=Crossover_nOrder(x1,x2)

n=3;
nn=2*n;

nVar=numel(x1);
c=randsample(nVar,nn);
c=sort(c);

ind_y=[];

for i=1:2:nn
    ind_y=[ind_y c(i):c(i+1)];
end

ind_yp=setdiff(1:nVar, ind_y);

y1=zeros(1,nVar);
y2=zeros(1,nVar);

% Offspring 1
sp1=x1(ind_y);
sp2=setdiff(x2,sp1,'stable');
y1(ind_y)=sp1;
y1(ind_yp)=sp2;

% Offspring 2
sp1=x2(ind_y);
sp2=setdiff(x1,sp1,'stable');
y2(ind_y)=sp1;
y2(ind_yp)=sp2;

end

