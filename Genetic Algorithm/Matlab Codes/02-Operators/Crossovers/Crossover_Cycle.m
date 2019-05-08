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