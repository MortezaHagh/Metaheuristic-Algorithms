function x=ParseSolution(xhat, model)

I=model.I;
J=model.J;
a=model.a;

x=zeros(I,J);

for i=1:I
    x(i,:)=a(i)*xhat(i,:)/sum(xhat(i,:));
end

end