function Emp=UpdateTotalCost(Emp)

global ICAsetting;
zeta=ICAsetting.zeta;

nEmp=numel(Emp);
for i=1:nEmp
    if Emp(i).nCol>0
        Emp(i).TotalCost=Emp(i).Imp.Cost+zeta*mean([Emp(i).Col.Cost]);
    else
        Emp(i).TotalCost=Emp(i).Imp.Cost;
    end
end
end