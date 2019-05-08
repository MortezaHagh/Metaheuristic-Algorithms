function Emp=Assimilation(Emp)

global ProblemSetting;
CostFunction=ProblemSetting.CostFunction;
VarSize=ProblemSetting.VarSize;
VarMin=ProblemSetting.VarMin;
VarMax=ProblemSetting.VarMax;

global ICAsetting;
beta=ICAsetting.beta;

nEmp=numel(Emp);
for i=1:nEmp
    for j=1:Emp(i).nCol
        Emp(i).Col(j).Position = Emp(i).Col(j).Position + ...
            beta*rand(VarSize).*(Emp(i).Imp.Position-Emp(i).Col(j).Position);
        
        Emp(i).Col(j).Position=min(VarMax,Emp(i).Col(j).Position);
        Emp(i).Col(j).Position=max(VarMin,Emp(i).Col(j).Position);
        Emp(i).Col(j).Cost=CostFunction(Emp(i).Col(j).Position);
    end
end

end
