function [Island]=Migration(Island)

global ICAsetting;
MigrationSize=ICAsetting.MigrationSize;
Ncube=ICAsetting.Ncube;

for i=1:Ncube
    POP1=Island(i).Emp(1).Col;   % First Population
    nCol1=Island(i).Emp(1).nCol;
    if i+1<=Ncube                % Second Population
        POP2=Island(i+1).Emp(1).Col;
        nCol2=Island(i+1).Emp(1).nCol;
    else
        POP2=Island(1).Emp(1).Col;
        nCol2=Island(1).Emp(1).nCol;
    end
    
    Q1=[1 2 randi([2,nCol1],[1 MigrationSize])];
    Q2=[1 2 randi([2,nCol2],[1 MigrationSize])];
    POPM1=POP1(Q1);
    POPM2=POP2(Q2);
    
    POP1(Q1)=POPM2;
    POP2(Q2)=POPM1;
    
    Island(i).Emp(1).Col=POP1;
    if i+1<=Ncube
        Island(i+1).Emp(1).Col=POP2;
    else
        Island(1).Emp(1).Col=POP2;
    end
    
end

end