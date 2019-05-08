function []=AdaptiveSelectionPressure(Imp)

global ICASettings;
a=ICASettings.alpha;

ImpCost=[Imp.Cost];
n=numel(ImpCost);
P=exp(-a*ImpCost/max(ImpCost));

if sum(P(1:round(n/2))<0.8)
    a=a+5;
elseif sum(P(1:round(n/2))<0.8)
    a=a/2;
end

a=max(a,300);
ICASettings.alpha=a;

end