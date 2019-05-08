function [a]=EnsembleM(z1,z2)

if z2>z1  % Mutate Path Is Better
    a=1;
else if z2==z1
        a=0.5;
    else
        a=0;
    end
end

end