function emp=DoRevolution(emp)

global ProblemSettings;
CostFunction=ProblemSettings.CostFunction;

global ICASettings;
pRevolution=ICASettings.pRevolution;

nEmp=numel(emp);
for k=1:nEmp
    
    NewImp.Position=PermutationRevolution(emp(k).Imp.Position);
    [NewImp.Cost,NewImp.Sol]=CostFunction(NewImp.Position);
    if NewImp.Cost<emp(k).Imp.Cost
        emp(k).Imp = NewImp;
    end
    
    for i=1:emp(k).nCol
        if rand<=pRevolution
            emp(k).Col(i).Position = PermutationRevolution(emp(k).Col(i).Position);
            [emp(k).Col(i).Cost,emp(k).Col(i).Sol] = CostFunction(emp(k).Col(i).Position);
        end
    end
end

end