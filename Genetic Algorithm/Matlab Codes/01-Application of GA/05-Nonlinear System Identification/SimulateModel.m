function out=SimulateModel(params)

a=params.a;
b=params.b;
c=params.c;
d=params.d;

x10=params.x10;
x20=params.x20;

T=params.T;
dt=params.dt;

t=0:dt:T;
K=numel(t);

x1=zeros(1,K);
x2=zeros(1,K);

x1(1)=x10;
x2(1)=x20;

for k=1:K-1
    x1(k+1)=x1(k)+(a*x1(k)-b*x1(k)*x2(k))*dt;
    x2(k+1)=x2(k)+(-c*x2(k)+d*x1(k)*x2(k))*dt;
end

out.t=t;
out.x1=x1;
out.x2=x2;

end