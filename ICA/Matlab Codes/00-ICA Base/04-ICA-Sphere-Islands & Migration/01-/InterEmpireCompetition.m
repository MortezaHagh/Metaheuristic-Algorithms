function Emp=InterEmpireCompetition(n,Emp)

global ICAsetting;
a=ICAsetting.a(n);

nEmp=numel(Emp);
if nEmp==1
    return
end

TotalCost=[Emp.TotalCost];
[~, WeakestEmpIndex]=max(TotalCost);
WeakestEmp=Emp(WeakestEmpIndex);

P=exp(-a*TotalCost/max(TotalCost));
P(WeakestEmpIndex)=0;
P=P/sum(P);

if WeakestEmp.nCol>0
    [~, WeakestColIndex]=max([WeakestEmp.Col.Cost]);
    WeakestCol=WeakestEmp.Col(WeakestColIndex);
    
    WinnerEmpIndex=Roulettewheel(P);
    WinnerEmp=Emp(WinnerEmpIndex);
    
    WinnerEmp.Col(end+1)=WeakestCol;
    WinnerEmp.nCol=Emp(WinnerEmpIndex).nCol+1;
    Emp(WinnerEmpIndex)=WinnerEmp;
    
    WeakestEmp.Col(WeakestColIndex)=[];
    WeakestEmp.nCol=WeakestEmp.nCol-1;
    Emp(WeakestEmpIndex)=WeakestEmp;
end

if WeakestEmp.nCol==0
    
    WinnerEmpIndex2=Roulettewheel(P);
    WinnerEmp2=Emp(WinnerEmpIndex2);
    
    WinnerEmp2.Col(end+1)=WeakestEmp.Imp;
    WinnerEmp2.nCol=WinnerEmp2.nCol+1;
    Emp(WinnerEmpIndex2)=WinnerEmp2;
    
    Emp(WeakestEmpIndex)=[];
end

end