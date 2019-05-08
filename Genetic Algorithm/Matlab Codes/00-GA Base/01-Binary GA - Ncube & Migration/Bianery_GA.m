clc
clear
close all

%% Problem Definition
global NFE;
NFE=0;
CostFunction=@(x) MinOne(x);   % Cost Function
nVar=200;                      % Num of Decision Variables
VarSize=[1 nVar];              % Decision Variables Matrix Size

%% GA Parameters
Ncube=3;               % Number of Islands
MaxIt=200;             % Max Num of Iterations
nPop=50;               % Population Size
pc=0.8;                % Crossover Perventage
nc=2*round(pc*nPop/2); % Number of offsprings(or Parents)
pm=0.3;                % Mutation Percentage
nm=round(pm*nPop);     % Number of Mutants
mu=0.01;               % Mutation Rate
beta=8;                % Selection Pressure
TournomentSize=3;      % Tournoment Size

% Input Dialogue
answer = inputdlg({'Migration Interval', 'Migration Size'},'nCube GA',1,{'15','5'});

% Migration Properties
MigrationInterval=str2double(answer{1});       % Number of Iterations Between Two Migration
MigrationSize=str2double(answer{2});           % Migration Size Should be More than 3

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
pop=repmat(empty_individual,nPop,1);

Empty_Island.pop=repmat(empty_individual,nPop,1);
Island=repmat(Empty_Island,Ncube,1);

for j=1:Ncube
    for i=1:nPop
        % Initial Position
        Island(j).pop(i).Position=randi([0 1],VarSize);
        % Evaluation
        Island(j).pop(i).Cost=CostFunction(Island(j).pop(i).Position);
    end
    
    % Sort Population
    Costs=[Island(j).pop.Cost];
    [~, SortOrder]=sort(Costs);
    Island(j).pop=Island(j).pop(SortOrder);
    
end

% Array Holding Best Cost Values
BestCost=zeros(MaxIt,Ncube);
BestCostTot=zeros(MaxIt,1);

% Array to hold Num of Function Evaluation
nfe=zeros(MaxIt,1);
WorstCost=zeros(Ncube,1);

%% Main Loop
for it=1:MaxIt
    
    % Migration
    if rem(it,MigrationInterval)==0
        disp('Migration Model "Information Exchange"')
        [Island]=MigrationModel(nPop, Ncube, MigrationSize, Island);
    end
    
    for n=1:Ncube
        
        pop=(Island(n,1).pop);
        Costs=pop.Cost;
        
        % Update Worst Cost
        WorstCost(n)=max(WorstCost(n),pop(end).Cost);
        
        % Calculate Selection Probablities
        P=exp(-beta*Costs/WorstCost(n));
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
            
            % Select Parents
            p1=pop(i1);
            p2=pop(i2);
            
            % Apply Crossover
            [popc(k,1).Position, popc(k,2).Position]=Crossover(p1.Position, p2.Position);
            
            % Evaluation Offsprings
            popc(k,1).Cost=CostFunction(popc(k,1).Position);
            popc(k,2).Cost=CostFunction(popc(k,2).Position);
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
            popm(k,1).Cost=CostFunction(popm(k,1).Position);
            
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
        
        % Best Solution Ever Found
        BestSol=pop(1);
        
        % Store Best Cost
        BestCost(it, n)=BestSol.Cost;
        
        % Store NFE
        nfe(it)=NFE;
        
        % Update Islands
        Island(n,1).pop=pop;
        pop=[];
        
        % Show Iteration Information
        disp(['Island ' num2str(n) '  Iteration ' num2str(it) '  NFE = ' num2str(nfe(it)) ' : Best Cost = ' num2str(BestCost(it,n))]);
    end
    
    BestCostTot(it)= min(BestCost(it,:));
    disp(['Total Best Cost = ' num2str(BestCostTot(it))]);
    
end

%% Results
figure;
plot(nfe,BestCost,'LineWidth',2);
xlabel('NFE');
ylabel('BestCost');

