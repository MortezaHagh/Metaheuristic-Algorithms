function [Island]=MigrationModel(nPop, Ncube, MigrationSize, Island)

for i=1:Ncube
    POP1=Island(i).pop;       % First Population
    if i+1<=Ncube
        POP2=Island(i+1).pop; % Second Population
    else
        POP2=Island(1).pop;
    end
    
    Q1=randi([3,nPop],[1 MigrationSize-2]); Q1=[1 2 Q1];
    Q2=randi([3,nPop],[1 MigrationSize-2]); Q2=[1 2 Q2];
    
    POPM1=POP1(Q1);
    POPM2=POP2(Q2);
    
    POP1((nPop-MigrationSize+1):nPop)=POPM2;
    POP2((nPop-MigrationSize+1):nPop)=POPM1;
    
    Island(i).pop=POP1;
    if i+1<=Ncube
        Island(i+1).pop=POP2;
    else
        Island(1).pop=POP2;
    end
    
end

end