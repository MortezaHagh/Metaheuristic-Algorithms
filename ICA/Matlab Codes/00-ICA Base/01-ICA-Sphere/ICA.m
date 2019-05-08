clc
clear
close all
tic

%% Problem Definition
CostFunction=@(x) Sphere(x);
nVar=5;             % Num of Variables
VarSize=[1 nVar];   % Answer Vector Size
VarMin=-10;
VarMax=10;

%% ICA Settings
MaxIt=100;            % Maximum Number of Iterations
nPop=50;              % Population Size (Countries)
nEmp=10;              % Num of Empires/Imperialists
a=1;                  % Selection Pressure
beta=2;               % Assimilation Coefficient
pRev=0.1;             % Revolution Probiblity
mu=0.05;              % Revolution Rate
zeta=0.1;             % Colonies Mean Cost Coefficient

% Save Parameters
ShareSettings;

%% Initialization

% Creat Initial Empires
Emp=CreatInitialEmpires();

% Array to Hold Best Cost
BestCost=zeros(MaxIt,1);

%% ICA Main Loop
for It=1:MaxIt
    
    % Assimilation
    Emp=Assimilation(Emp);
    
    % Revolution
    Emp=Revolution(Emp);
    
    % Intra-Empire Competition
    Emp=IntraEmpireCompetition(Emp);
    
    % Update Total Cost of Empires
    Emp=UpdateTotalCost(Emp);
    
    % Inter-Empire Competition
    Emp=InterEmpireCompetition(Emp);
    
    % Update Best Solution Ever Found
    imp=[Emp.Imp];
    [~, BestImpIndex]=min([imp.Cost]);
    BestSol=imp(BestImpIndex);
    
    % Update Best Cost
    BestCost(It)=BestSol.Cost;
    
    % Show Iteration Information
    disp(['Iteration Num :  ' num2str(It)  '    Best Cost : '  num2str(BestCost(It))])
end
toc

%% Show Results
figure;
semilogy(BestCost,'LineWidth',2)

