function Emp=Revolution(n,Emp)

global ProblemSetting;
CostFunction=ProblemSetting.CostFunction;
VarSize=ProblemSetting.VarSize;
VarMin=ProblemSetting.VarMin;
VarMax=ProblemSetting.VarMax;

global ICAsetting;
pRev=ICAsetting.pRev;
mu=ICAsetting.mu;
Rev=ICAsetting.Rev;
rev=Rev(n);

nVar=VarSize(1,2);
nmu=ceil(mu*nVar);
sigma=rev*(VarMax-VarMin);
nEmp=numel(Emp);
Temp=1;

% for Imperialists
for i=1:nEmp
    jj=randsample(nVar,nmu)';
    newPosition=Emp(i).Imp.Position+sigma*randn(VarSize);
    NewImp.Position=Emp(i).Imp.Position;
    NewImp.Position(jj)=newPosition(jj);
    
    NewImp.Position=min(VarMax,Emp(i).Imp.Position);
    NewImp.Position=max(VarMin,Emp(i).Imp.Position);
    NewImp.Cost=CostFunction(Emp(i).Imp.Position);
    
    if NewImp.Cost<Emp(i).Imp.Cost
        Emp(i).Imp=NewImp;
    end
    
    % for Colonires
    for j=1:Emp(i).nCol
        if rand<=pRev
            jj=randsample(nVar,nmu)';
            newPosition=Emp(i).Col(j).Position+sigma*rand(VarSize);
            Emp(i).Col(j).Position(jj)=newPosition(jj);
            
            Emp(i).Col(j).Position=min(VarMax,Emp(i).Col(j).Position);
            Emp(i).Col(j).Position=max(VarMin,Emp(i).Col(j).Position);
            
            OldCost=Emp(i).Col(j).Cost;
            NewCost=CostFunction(Emp(i).Col(j).Position);
            Emp(i).Col(j).Cost=NewCost;
            if OldCost < NewCost
                Temp=Temp+1;
            end
            
        end
    end
end

% Applying Schewefels Rule
SuccesfulPercent=Temp/sum([Emp.nCol]);
if SuccesfulPercent>0.2
    rev=rev*2;
else
    rev=rev/2;
end
Rev(n)=rev;
ICAsetting.Rev=Rev;

end