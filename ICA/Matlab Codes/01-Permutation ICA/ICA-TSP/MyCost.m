function [z ,sol]=MyCost(s,model)

[~ ,tour]=sort(s);
sol.tour=tour;
n=numel(tour);
tour=[tour tour(1)];
d=model.d;
L=0;

for i=1:n
    L=L+d(tour(i),tour(i+1));
end

sol.L=L;
z=L;

end