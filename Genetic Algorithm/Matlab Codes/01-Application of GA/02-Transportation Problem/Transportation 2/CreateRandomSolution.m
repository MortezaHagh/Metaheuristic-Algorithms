function sol1=CreateRandomSolution(model)

I=model.I;
J=model.J;

sol1.f=randi([0 1],1,J);
sol1.xhat=rand(I,J);

end