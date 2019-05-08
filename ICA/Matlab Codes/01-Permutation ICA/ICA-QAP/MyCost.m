function [z ,Sol]=MyCost(s,model)

[~, p]=sort(s);
n=model.n;
w=model.w;
d=model.d;

p=p(1:n);
z=0;
for i=1:n-1
    for j=i+1:n
        z=z+w(i,j)*d(p(i),p(j));
    end
end

Sol.p=p;
Sol.z=z;

end
