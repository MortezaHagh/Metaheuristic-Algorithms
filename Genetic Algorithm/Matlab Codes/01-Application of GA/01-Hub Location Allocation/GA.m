clc
clear
close all

%% Problem Definition
global NFE;
NFE=0;
model=CreateModel();
model.w1=1;
model.w2=1;
CostFunction=@(f) MyCost(f,model);
nVar=model.M;
VarSize=[1 nVar];
tic

%% GA Parameters
MaxIt=100;             % Max Num of Iterations
nPop=20;               % Population Size
pc=0.8;                % Crossover Percentage
nc=2*round(pc*nPop/2); % Number of offsprings(Parents)
pm=0.3;                % Mutation Percentage
nm=round(pm*nPop);     % Number of Mutants
mu=0.02;               % Mutation Rate
beta=8;                % Selection Pressure
TournomentSize=3;      % Tournoment Size

% Selection Method
Answer=questdlg('Selection Method?','Genetic Algorithm',...
    'Roulette Wheel','Tournoment','Random','Roulette Wheel');
UseRoulettewheel=strcmp(Answer,'Roulette Wheel');
UseTournoment=strcmp(Answer,'Tournoment');
UseRandom=strcmp(Answer,'Random');
pause(0.1);

%% Initialization
empty_individual.Position=[];
empty_individual.Cost=[];
empty_individual.sol=[];
pop=repmat(empty_individual,nPop,1);

for i=1:nPop
    % Initial Position
    pop(i).Position=CreateRandomSolution(model);
    % Evaluation
    [pop(i).Cost, pop(i).sol]=CostFunction(pop(i).Position);
end

% Sort Population
Costs=[pop.Cost];
[Costs, SortOrder]=sort(Costs);
pop=pop(SortOrder);

% Store Best Solution
BestSol=pop(1);

% Array Holding Best Cost Values
BestCost=zeros(MaxIt,1);
BestCost(1)=BestSol.Cost;

WorstCost=pop(end).Cost;

% Array to hold Num of Function Evaluation
nfe=zeros(MaxIt,1);

%% Main Loop
for it=1:MaxIt
    
    % Calculate Selection Probablities
    P=exp(-beta*Costs/WorstCost);
    P=P/sum(P);
    
    %%%%% Crossover
    popc=repmat(empty_individual,nc/2,2);
    for k=1:nc/2
        
        % Select Parents Indices
        % Random
        if UseRandom
            i1=randi([1 nPop]);
            i2=randi([1 nPop]);
        end
        
        % Roulette Wheel
        if UseRoulettewheel
            i1=RouletteWheelSelection(P);
            i2=RouletteWheelSelection(P);
        end
        
        % Tournoment
        if UseTournoment
            i1=TournomentSelection(pop,TournomentSize);
            i2=TournomentSelection(pop,TournomentSize);
        end
        
        % Select  Parents
        p1=pop(i1);
        p2=pop(i2);
        
        % Apply Crossover
        [popc(k,1).Position, popc(k,2).Position]=Crossover(p1.Position, p2.Position);
        
        % Evaluation Offsprings
        [popc(k,1).Cost, popc(k,1).sol]=CostFunction(popc(k,1).Position);
        [popc(k,2).Cost, popc(k,2).sol]=CostFunction(popc(k,2).Position);
    end
    popc=popc(:);
    
    %%%% Mutation
    popm=repmat(empty_individual,nm,1);
    
    for k=1:nm
        
        % Select Parent
        i=randi([1 nPop]);
        p=pop(i);
        
        % Apply Mutation
        popm(k,1).Position=Mutation(p.Position,mu);
        
        % Evaluate Mutant
        [popm(k,1).Cost, popm(k,1).sol]=CostFunction(popm(k,1).Position);
        
    end
    
    %%%%% Merg, Sort, Truncation
    
    % Create Merged Population
    pop=[pop; popc; popm];
    
    % Sort
    Costs=[pop.Cost];
    [Costs, SortOrder]=sort(Costs);
    pop=pop(SortOrder);
    
    % Truncate
    pop=pop(1:nPop);
    Costs=Costs(1:nPop);
    
    %%%%% Results
    
    % Store Best Solution Ever Found
    BestSol=pop(1);
    
    % Store Best Cost
    BestCost(it)=BestSol.Cost;
    
    % Update Worst Cost
    WorstCost=max(WorstCost,pop(end).Cost);
    
    % Store NFE
    nfe(it)=NFE;
    
    % Show Iteration Information
    disp(['Iteration ' num2str(it) '  NFE = ' num2str(nfe(it)) ' : Best Cost = ' num2str(BestCost(it))]);
    
    % Plot Solution
    figure(1)
    PlotSolution(BestSol.Position, model);
    pause(0.1)
end
toc
%% Results
figure;
plot(nfe,BestCost,'LineWidth',2);
xlabel('NFE');
ylabel('BestCost');

