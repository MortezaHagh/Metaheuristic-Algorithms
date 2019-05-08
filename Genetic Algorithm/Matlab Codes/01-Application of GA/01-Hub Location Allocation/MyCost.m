function [z, sol]=MyCost(f, model)

global NFE
if isempty(NFE)
    NFE=0;
end
NFE=NFE+1;

if all(f==0)
    z=inf;
    sol=[];
    return;
end

dc=model.dc;
N=model.N;
D=model.D;
cs=model.cs;
w1=model.w1;
w2=model.w2;

Dmin=zeros(1,N);
A=zeros(1,N);
for i=1:N
    [Dmin(i), A(i)]=min(D(i,:)./f);
end

z1=sum(dc.*Dmin);
z2=sum(f.*cs);
z=w1*z1+w2*z2;

sol.A=A;
sol.Dmin=Dmin;
sol.z1=z1;
sol.z2=z2;
sol.z=z;

end