function Island=CreatInitialEmpires()

% Settings
global ProblemSetting;
CostFunction=ProblemSetting.CostFunction;
VarSize=ProblemSetting.VarSize;
VarMin=ProblemSetting.VarMin;
VarMax=ProblemSetting.VarMax;

global ICAsetting;
a=ICAsetting.a;
nPop=ICAsetting.nPop;
nEmp=ICAsetting.nEmp;
nCol=nPop-nEmp;
Ncube=ICAsetting.Ncube;

%%%
empty_Country.Position=[];
empty_Country.Cost=[];
Country=repmat(empty_Country,nPop,1);

empty_Emp.Imp=[];
empty_Emp.Col=repmat(empty_Country,0,1);
empty_Emp.nCol=0;
empty_Emp.TotalCost=[];
Emp=repmat(empty_Emp,nEmp,1);
Island=repmat(Emp,2,1);

for n=1:Ncube
    
    % Create Countries
    for i=1:nPop
        Country(i).Position=unifrnd(VarMin,VarMax,VarSize);
        Country(i).Cost=CostFunction(Country(i).Position);
    end
    Costs=[Country.Cost];
    [~, SortOrder]=sort(Costs);
    Country=Country(SortOrder);
    
    % Impires & Colonies
    imp=Country(1:nEmp);
    col=Country(nEmp+1:end);
    
    % Assign Impires
    for i=1:nEmp
        Emp(i).Imp=imp(i);
    end
    
    % Assign Colonies
    MaxCost=max([imp.Cost]);
    P=exp(-a(n)*[imp.Cost]/MaxCost);
    P=P/sum(P);
    for k=1:nCol
        i=Roulettewheel(P);
        Emp(i).Col=[Emp(i).Col ; col(k)];
        Emp(i).nCol=Emp(i).nCol+1;
    end
    
    % Total Cost
    Emp=UpdateTotalCost(Emp);
    
    Island(n).Emp=Emp;
end

end