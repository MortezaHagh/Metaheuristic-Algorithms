clc
clear
close all

%% Problem Definition
global NFE;
NFE=0;
model=CreateModel();
CostFunction=@(s) MyCost(s,model);
nVar=model.n;
VarSize=[1 nVar];

%% GA Parameters
MaxIt=200;             % Max Num of Iterations
nPop=50;               % Population Size
pc=0.8;                % Crossover Percentage
nc=2*round(pc*nPop/2); % Number of offsprings(Parents)
pm=0.5;                % Mutation Percentage
nm=round(pm*nPop);     % Number of Mutants
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
pop=repmat(empty_individual,nPop,1);

for i=1:nPop
    % Initial Position
    pop(i).Position=CreateRandomSolution(model);
    % Evaluation
    pop(i).Cost=CostFunction(pop(i).Position);
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

% X: Crossover, M: Mutation
% PHI{i,1} : Shows Performance of the Operators
% PHI{i,2} : Times of Using the Operator
for ii=1:7
    PHIX{ii,1}=1/4; PHIX{ii,2}=1;
end

for jj=1:4
    PHIM{jj,1}=1/4; PHIM{jj,2}=1;
end

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
        [popc(k,1).Position, popc(k,2).Position, M]=Crossover(p1.Position, p2.Position,PHIX);
        % Evaluation Offsprings
        popc(k,1).Cost=CostFunction(popc(k,1).Position);
        popc(k,2).Cost=CostFunction(popc(k,2).Position);
        
        [a,b]=EnsembleX(p1.Cost, p2.Cost, popc(k,1).Cost, popc(k,2).Cost, it, MaxIt);
        PHIX{M,1}(1,end+1)=a;
        PHIX{M,1}(1,end+1)=b;
        PHIX{M,2}=PHIX{M,2}+1;

    end
    popc=popc(:);
    
    %%%% Mutation
    popm=repmat(empty_individual,nm,1);
    
    for k=1:nm
        
        % Select Parent
        i=randi([1 nPop]);
        p=pop(i);
        
        % Apply Mutation
        [popm(k,1).Position, M]=Mutation(p.Position, PHIM);
        % Evaluate Mutant
        popm(k,1).Cost=CostFunction(popm(k,1).Position);
        
        [a]=EnsembleM(p.Cost, popm(k,1).Cost);
        PHIM{M,1}(1,end+1)=a;
        PHIM{M,2}=PHIM{M,2}+1;

    end
    
    %%%%% Merg, Sort, Truncation
    
    % Create Merged Population
    pop=[pop;popc;popm];
    
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
    
    % Plot Best Solution
    figure(1)
    PlotSolution(BestSol.Position,model)
    pause(0.01)
end
%%% End of GA Main Loop

%% Operators Performance
% Prog(i) : Relative Performance of the Operators
Prog=zeros(1,7);
for i=1:size(PHIX,1)
    Prog(i)=sum(PHIX{i,1})/PHIX{i,2};
end
PX=100*(Prog/sum(Prog));
clear Prog

Prog=zeros(1,4);
for i=1:size(PHIM,1)
    Prog(i)=sum(PHIM{i,1})/PHIM{i,2};
end
PM=100*(Prog./sum(Prog));
clear Prog

clear a b Costs i i1 i2 ii it jj k M nc nm p p1 p2 popc popm SortOrder Answer;
clear UseRoulettewheel UseRandom WorstCost UseTournoment empty_individual P;

%% Results
figure;
plot(nfe,BestCost,'LineWidth',2);
xlabel('NFE');
ylabel('BestCost');

