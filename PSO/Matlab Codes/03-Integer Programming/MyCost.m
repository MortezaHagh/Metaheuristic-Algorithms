function [z, Sol]=MyCost(x, P, M)

global NFE;
if isempty(NFE)
    NFE=0;
end
NFE=NFE+1;

K=min(floor(1+M*x),M);
v=abs(prod(K)/P-1);
beta=10;
z=sum(K)*(1+beta*v);

Sol.K=K;
Sol.Prod=prod(K);
Sol.Sum=sum(K);
Sol.z=z;
Sol.v=v;

end