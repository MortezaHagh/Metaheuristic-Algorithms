function [z ,sol]=MyCost(s,model)

global NFE;
NFE=NFE+1;

sol.tour=s;
n=model.n;
tour=[s s(1)];
d=model.d;
L=0;

for i=1:n
    L=L+d(tour(i),tour(i+1));
end

sol.L=L;
z=L;

end