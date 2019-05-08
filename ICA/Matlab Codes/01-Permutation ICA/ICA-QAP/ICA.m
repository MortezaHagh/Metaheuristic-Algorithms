clc;
clear;
close all;

%% Problem Definition
model=CreatModel();
CostFunction=@(s) MyCost(s,model);
nVar=model.m;       % Number of Decision Variables
VarSize=[1 nVar];   % Decision Variables Matrix Size
VarMin=0;           % Lower Bound of Variables
VarMax=1;           % Upper Bound of Variables

%% ICA Parameters
MaxIt=200;          % Maximum Number of Iterations
nPop=50;            % Population Size
nEmp=10;            % Number of Empires/Imperialists
alpha=1;            % Selection Pressure
beta=2;             % Assimilation Coefficient
pRevolution=0.1;    % Revolution Probability
mu=0.05;            % Revolution Rate
zeta=0.1;           % Colonies Mean Cost Coefficient

% Save Parameters
ShareSettings;

%% Initialization

% Initialize Empires
emp=CreatInitialEmpires();

% Array to Hold Best Cost Values
BestCost=zeros(MaxIt,1);

%% ICA Main Loop

for it=1:MaxIt
    
    % Adaptive Selection Pressure
    AdaptiveSelectionPressure([emp.Imp]);
    
    % Assimilation
    emp=AssimilateColonies(emp);
    
    % Revolution
    emp=DoRevolution(emp);
    
    % Intra-Empire Competition
    emp=IntraEmpireCompetition(emp);
    
    % Update Total Cost of Empires
    emp=UpdateTotalCost(emp);
    
    % Inter-Empire Competition
    emp=InterEmpireCompetition(emp);
    
    % Update Best Solution Ever Found
    imp=[emp.Imp];
    [~, BestImpIndex]=min([imp.Cost]);
    BestSol=imp(BestImpIndex);
    
    % Update Best Cost
    BestCost(it)=BestSol.Cost;
    
    % Show Iteration Information
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
    
    % Plot Best Solution
    figure(1);
    PlotSolution(BestSol.Sol.p,model);
    pause(0.05)
end

%% Results
figure(2);
plot(BestCost,'LineWidth',2);
xlabel('Iteration');
ylabel('Best Cost');
