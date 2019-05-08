function [y1, y2]=Crossover(x1, x2)

pSinglePointCrossover=0.1;
pDoublePointCrossover=0.2;
pUniformCrossover=1-pSinglePointCrossover-pDoublePointCrossover;

Method=RouletteWheelSelection([pSinglePointCrossover pDoublePointCrossover pUniformCrossover]);
switch Method
    case 1
        [y1, y2]=SinglePointCrossover(x1, x2);
    case 2
        [y1, y2]=DoublePointCrossover(x1, x2);
    case 3
        [y1, y2]=UniformCrossover(x1, x2);
end

    function [y1, y2]=SinglePointCrossover(x1, x2)
        nVar=numel(x1);
        c=randi([1 nVar-1]);
        
        y1=[x1(1:c) x2(c+1:end)];
        y2=[x2(1:c) x1(c+1:end)];
    end

    function [y1, y2]=DoublePointCrossover(x1, x2)
        nVar=numel(x1);
        cc=randsample(nVar-1,2);
        c1=min(cc);
        c2=max(cc);
        
        y1=[x1(1:c1) x2(c1+1:c2) x1(c2+1:end)];
        y2=[x2(1:c1) x1(c1+1:c2) x2(c2+1:end)];
    end

    function [y1, y2]=UniformCrossover(x1, x2)
        nVar=numel(x1);
        alpha=randi([0 1],1,nVar);
        
        y1=x1.*alpha+x2.*(1-alpha);
        y2=x2.*alpha+x1.*(1-alpha);
    end

end