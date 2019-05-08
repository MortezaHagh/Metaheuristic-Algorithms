function z=MyCost(s,model)

global NFE;
if isempty(NFE)
    NFE=0;
end
NFE=NFE+1;

n=model.n;
w=model.w;
d=model.d;
p=ParseSolution(s,model);

z=0;
for i=1:n
    for j=i+1:n
        z=z+w(i,j)*d(p(i),p(j));
    end
end

end