function [y1,y2]=Crossover_MultiParent(X)

n=numel(X(1,:));  %% chromosome length

%%% uni : combined data from Input Paths with no repetitions
uni=union(X(1,:),X(2,:));
for i=3:size(X,1)
    uni=union(uni,X(i,:));
end

%%% D : Desirability Matrix
% D(j,i) : How may times uni(i) is repeated in j'th column of X Matrix
D=zeros(n,length(uni));
epsilon=0.0005*rand(n,length(uni));
for i=1:size(D,2)        % length(uni)
    for j=1:size(D,1)    % n
        D(j,i)=length(find(X(:,j)==uni(i)));
    end
end
D=D+epsilon;

%%% Offsprings
sp=zeros(2,n);
for ss=1:2
    
    temp1=randperm(length(uni),length(uni));
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
