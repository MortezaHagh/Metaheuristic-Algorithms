function []=AdaptiveSelectionPressure(Imp)

global ICAsetting;
a=ICAsetting.a;

ImpCost=[Imp.Cost];
n=numel(ImpCost);
P=exp(-a*ImpCost/max(ImpCost));

if sum(P(1:round(n/2))<0.8)
    a=a+5;
else if sum(P(1:round(n/2))>0.95)
        a=a/2;
    end
end

a=max(a,400);
% a=min(a,1);

ICAsetting.a=a;

end