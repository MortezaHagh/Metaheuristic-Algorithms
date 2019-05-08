function [z, sol]=MyCost(q,model)

global NFE;
if isempty(NFE)
    NFE=0;
end
NFE=NFE+1;

params.T=model.T;
params.dt=model.dt;
params.x10=model.x10;
params.x20=model.x20;

params.a=q(1);
params.b=q(2);
params.c=q(3);
params.d=q(4);

out=SimulateModel(params);

e1=model.x1-out.x1;
e2=model.x2-out.x2;

z=mean(e1.^2)+mean(e2.^2);

sol.params=params;
sol.t=out.t;
sol.x1=out.x1;
sol.x2=out.x2;
sol.e1=e1;
sol.e2=e2;
sol.z=z;

end