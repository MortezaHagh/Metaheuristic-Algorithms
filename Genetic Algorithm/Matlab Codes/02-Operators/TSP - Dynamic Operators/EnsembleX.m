function [a,b]=EnsembleX(z1,z2,z3,z4,it,MaxIt)

if z3>z1 && z3>z2
    a=1;
else if z3==z1 && z3==z2
        a=0.5;
    else
        a=max(0.5-((0.6*it)/MaxIt),0); %???
    end
end

if z4>z1 && z4>z2
    b=1;
else if z4==z1 && z4==z2
        b=0.5;
    else
        b=max(0.5-((0.6*it)/MaxIt),0);
    end
end

end