function [z, sol]=KnapsackCost(x,model)

global NFE;
if isempty(NFE)
    NFE=0;
end
NFE=NFE+1;

w=model.w;
v=model.v;
W=model.W;

GainedValue=sum(v.*x);
LostValue=sum(v.*(1-x));
GainedWeight=sum(w.*x);
LostWeight=sum(w.*(1-x));

Violation=max(sum(w.*x)/W-1,0);

% alpha=10000;
% z=LostValue+alpha*Violation;

beta=10;
z=LostValue*(1+beta*Violation);

sol.GainedValue=GainedValue;
sol.LostValue=LostValue;
sol.GainedWeight=GainedWeight;
sol.LostWeight=LostWeight;
sol.Violation=Violation;
sol.z=z;
sol.IsFeasible=(Violation==0);

end