function [z, sol2]=MyCost(sol1, model)

global NFE;
if isempty(NFE)
    NFE=0;
end
NFE=NFE+1;

c=model.c;
e0=model.e0;
e1=model.e1;

sol2=ParseSolution(sol1, model);
f=sol2.f;
x=sol2.x;

CX=c.*x;
SumCX=sum(CX(:));

b=sol2.b;
e=e0+e1*b;
FE=f.*e;
SumFE=sum(FE(:));

TotalCost=SumCX+SumFE;

CAPv=max(sum(x,1)./b-1,0);
MeanCAPV=mean(CAPv(:));

beta=10;
z=TotalCost*(1+beta*MeanCAPV);

sol2.b=sol2.f.*sol2.b;
sol2.e=e;
sol2.x=x;
sol2.CX=CX;
sol2.FE=FE;
sol2.SumFE=SumFE;
sol2.SumCX=SumCX;
sol2.CAPv=CAPv;
sol2.MeanCAPV=MeanCAPV;
sol2.TotalCost=TotalCost;
sol2.z=z;
sol2.IsFeasible=(MeanCAPV==0);

end