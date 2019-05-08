function Emp=Revolution(Emp)

global ProblemSetting;
CostFunction=ProblemSetting.CostFunction;
VarSize=ProblemSetting.VarSize;
VarMin=ProblemSetting.VarMin;
VarMax=ProblemSetting.VarMax;

global ICAsetting;
pRev=ICAsetting.pRev;
mu=ICAsetting.mu;

nVar=VarSize(1,2);
nmu=ceil(mu*nVar);   % Num of the Variables in Colony that Revolt
sigma=0.1*(VarMax-VarMin);
nEmp=numel(Emp);

% Revolution in Imperialists
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
    
    % Revolution in Colonies
    for j=1:Emp(i).nCol
        if rand<=pRev
            jj=randsample(nVar,nmu)';
            newPosition=Emp(i).Col(j).Position+sigma*randn(VarSize);
            Emp(i).Col(j).Position(jj)=newPosition(jj);
            
            Emp(i).Col(j).Position=min(VarMax,Emp(i).Col(j).Position);
            Emp(i).Col(j).Position=max(VarMin,Emp(i).Col(j).Position);
            Emp(i).Col(j).Cost=CostFunction(Emp(i).Col(j).Position);
        end
    end
    
end

end