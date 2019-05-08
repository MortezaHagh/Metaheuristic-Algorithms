clc
clear
close all

%% Problem Definition
CostFunction=@(x) Sphere(x);
nVar=5;
VarSize=[1 nVar];
VarMin=-10;
VarMax=10;

%% ICA Settings

% Islands & Migration
Ncube=2;                  % Num of Islands
MigrationInterval=5;      % Number of Iterations Between Two Migration
MigrationSize=4;          % Migration Size Should be More than 3

MaxIt=100;                % Maximum Number of Iterations
nPop=50;                  % Population Size (Countries)
nEmp=10;                  % Num of Empires/Imperialists
a=ones(Ncube,1);          % Selection Pressure
beta=2;                   % Assimilation Coefficient
pRev=0.1;                 % Revolution Probiblity
Rev=0.1*ones(Ncube,1);    % Revolution Extent
mu=0.05;                  % Revolution Rate
zeta=0.1;                 % Colonies Mean Cost Coefficient

% Save Parameters
ShareSettings;

tic

%% Initialization

% Creat Initial Empires
Island=CreatInitialEmpires();

% Array to Hold Best Cost
BestCostTot=zeros(MaxIt,1);
BestCost=zeros(MaxIt,Ncube);

%% ICA Main Loop

for It=1:MaxIt
    for n=1:Ncube
        
        Emp=Island(n).Emp;
        
        % Adaptive Selection Pressure
        AdaptiveSelectionPressure(n,[Emp.Imp]);
        
        % Assimilation
        Emp=Assimilation(Emp);
        
        % Revolution
        Emp=Revolution(n,Emp);
        
        % Intra Empire Competition
        Emp=IntraEmpireCompetition(Emp);
        
        % Update Total Cost of Empires
        Emp=UpdateTotalCost(Emp);
        
        % Inter Empire Competition
        Emp=InterEmpireCompetition(n,Emp);
        
        % Update Best Solution Ever Found
        imp=[Emp.Imp];
        [~, BestImpIndex]=min([imp.Cost]);
        BestSol=imp(BestImpIndex);
        
        % Update Island
        Island(n).Emp=Emp;
        
        % Update Best Cost
        BestCost(It,n)=BestSol.Cost;
        
        % Show Iteration Information
        disp(['Iteration Num : ' num2str(It)  ', Island ' num2str(n) '    Best Cost : '  num2str(BestCost(It,n))])
    end
    
    % Update & Show Best Cost among Islands
    BestCostTot(It)=min(BestCost(It,:));
    disp(['Total Best Cost : ' num2str(BestCostTot(It))]);
    
    % Migration
    if rem(It,MigrationInterval)==0
        disp('Migration Model "Information Exchange"')
        [Island]=Migration(Island);
    end
    
end
toc

%% Show Results
figure;
semilogy(BestCost,'LineWidth',2)
