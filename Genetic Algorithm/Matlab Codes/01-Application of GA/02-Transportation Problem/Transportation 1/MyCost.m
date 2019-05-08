function [z, sol]=MyCost(xhat, model)

global NFE;
if isempty(NFE)
    NFE=0;
end
NFE=NFE+1;

x=ParseSolution(xhat, model);

c=model.c;
CX=c.*x;
SumCX=sum(CX(:));

CAPv=max(sum(x,1)./model.b-1,0);
MeanCAPV=mean(CAPv(:));

beta=10;
z=SumCX*(1+beta*MeanCAPV);

sol.x=x;
sol.CX=CX;
sol.SumCX=SumCX;
sol.CAPv=CAPv;
sol.MeanCAPV=MeanCAPV;
sol.z=z;
sol.IsFeasible=(MeanCAPV==0);

end