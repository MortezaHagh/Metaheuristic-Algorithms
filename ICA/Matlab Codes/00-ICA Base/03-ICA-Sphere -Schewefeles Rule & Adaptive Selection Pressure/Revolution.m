function Emp=Revolution(Emp)

global ProblemSetting;
CostFunction=ProblemSetting.CostFunction;
VarSize=ProblemSetting.VarSize;
VarMin=ProblemSetting.VarMin;
VarMax=ProblemSetting.VarMax;

global ICAsetting;
pRev=ICAsetting.pRev;
mu=ICAsetting.mu;
Rev=ICAsetting.Rev;

nVar=VarSize(1,2);
nmu=ceil(mu*nVar);
sigma=Rev*(VarMax-VarMin);
nEmp=numel(Emp);
Temp1=0;
Temp2=0;

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
            Temp2=Temp2+1;
            if OldCost < NewCost
                Temp1=Temp1+1;
            end
            
        end
    end
end

% Applying Schewefels Rule
% SuccesfulPercent=Temp1/Temp2;
% if SuccesfulPercent>0.2
%     pRev=pRev*1.1;
% else
%     pRev=pRev/1.1;
% end
% ICAsetting.pRev=pRev;

end
