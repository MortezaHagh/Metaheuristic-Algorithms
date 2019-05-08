function []=AdaptiveSelectionPressure(n,Imp)


global ICAsetting;
a=ICAsetting.a;

Tempa=a(n);
ImpCost=[Imp.Cost];
n=numel(ImpCost);
P=exp(-Tempa*ImpCost/max(ImpCost));
P=P/sum(P);
if sum(P(1:round(n/2))<0.8)
    Tempa=Tempa+5;
elseif sum(P(1:round(n/2))>0.9)
    Tempa=Tempa/2;
end

Tempa=max(Tempa,300);
a(n)=Tempa;
ICAsetting.a=a;

end
