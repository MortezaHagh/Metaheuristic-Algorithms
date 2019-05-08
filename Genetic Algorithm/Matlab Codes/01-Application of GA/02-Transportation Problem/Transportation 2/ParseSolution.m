function sol2=ParseSolution(sol1, model)

I=model.I;
J=model.J;
a=model.a;
xhat=sol1.xhat;
f=sol1.f;

x=zeros(I,J);
if any(f~=0)
    for i=1:I
        x(i,:)=a(i)*f.*xhat(i,:)/sum(f.*xhat(i,:));
    end
else
    x(:)=1e20;
end

sol2.f=f;
sol2.x=x;

end