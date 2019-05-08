function [z ,sol]=MyCost(s,model)

[~, q]=sort(s);
n=model.n;
p=model.p;
s=model.s;
d=model.d;
w1=model.w1;
w2=model.w2;

ST=zeros(1,n);
FT=zeros(1,n);

ST(q(1))=0;
FT(q(1))=ST(q(1))+p(q(1));

for i=2:n
    job=q(i);       % Process Number
    p_job=q(i-1);   % previous
    ST(job)=FT(p_job)+s(p_job,job);
    FT(job)=ST(job)+p(job);
end

Cmax=FT(q(end));

% Tardiness
Tard=max(FT-d,0);
TotalTard=sum(Tard);
z=w1*Cmax+w2*TotalTard;

sol.ST=ST;
sol.FT=FT;
sol.Cmax=Cmax;
sol.Tard=Tard;
sol.TotalTard=TotalTard;
sol.z=z;
sol.q=q;

end