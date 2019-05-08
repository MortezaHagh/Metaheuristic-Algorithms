function [y1,y2]=Crossover_nOrder(x1,x2)

n=3;
nn=2*n;

nVar=numel(x1);
c=randsample(nVar,nn);
c=sort(c);

% dc=diff(c);
% dc=dc(1:2:end)+1;
% nc=sum(dc);

ind_y=[];  %zeros(1,nc);

for i=1:2:nn
    ind_y=[ind_y c(i):c(i+1)];
end

ind_yp=setdiff(1:nVar, ind_y);

y1=zeros(1,nVar);
y2=zeros(1,nVar);

% Offspring 1
sp1=x1(ind_y);
sp2=setdiff(x2,sp1,'stable');
y1(ind_y)=sp1;
y1(ind_yp)=sp2;

% Offspring 2
sp1=x2(ind_y);
sp2=setdiff(x1,sp1,'stable');
y2(ind_y)=sp1;
y2(ind_yp)=sp2;

end