function [y1,y2]=Crossover_EdgeRecombination(x1,x2)

uni=union(x1,x2);
n=numel(uni);

% Neighbor List Table
Table=zeros(n,4);

for i=1:n
    
    % temp2 : x1 & x2 indices with value uni(i), if not exist put zero
    if any(x1==uni(i))
        temp2(1)=find(x1==uni(i));
    else
        temp2(1)=0;
    end
    
    if any(x2==uni(i))
        temp2(2)=find(x2==uni(i));
    else
        temp2(2)=0;
    end
    
    % temp3 : indices of uni(i) neighbors in x1
    if temp2(1)~=0
        if temp2(1)==1
            temp3=[n 2];
        elseif temp2(1)==n
            temp3=[n-1 1];
        else
            temp3=[temp2(1)-1 temp2(1)+1];
        end
    else
        temp3=[];
    end
    
    % temp4 : indices of uni(i) neighbors in x2
    if temp2(2)~=0
        if temp2(2)==1
            temp4=[n 2];
        elseif  temp2(2)==n
            temp4=[n-1 1];
        else
            temp4=[temp2(2)-1 temp2(2)+1];
        end
    else
        temp4=[];
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
y1=sp1(1:n);

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

y2=sp2(1:n);


end

