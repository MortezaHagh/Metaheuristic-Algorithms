function Emp=IntraEmpireCompetition(Emp)

nEmp=numel(Emp);
for i=1:nEmp
    for j=1:Emp(i).nCol
        if Emp(i).Col(j).Cost<Emp(i).Imp.Cost
            newImp=Emp(i).Col(j);
            newCol=Emp(i).Imp;
            
            Emp(i).Imp=newImp;
            Emp(i).Col(j)=newCol;
        end
    end
end

end