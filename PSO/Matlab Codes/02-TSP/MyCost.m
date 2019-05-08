function [z, Sol]=MyCost(x,model)

global NFE;
if isempty(NFE)
    NFE=0;
end
NFE=NFE+1;

D=model.D;
n=model.n;

[~, tour]=sort(x);
tour=[tour tour(1)];

L=0;
for k=1:n
    i=tour(k);
    j=tour(k+1);
    L=L+D(i,j);
end
z=L;

Sol.z=z;
Sol.tour=tour;

end
