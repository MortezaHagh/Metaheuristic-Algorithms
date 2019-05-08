function  n=SUSmethod(p,N)
% Stochastic universal sampling - SUS

r=rand/N;
np=numel(p);
n=zeros(1,np);
c=0;
i=0;
while sum(n)<N
    if r<=c
        n(i)=n(i)+1;
        r=r+1/N;
    else
        i=i+1;
        c=c+p(i);
    end
end

end
