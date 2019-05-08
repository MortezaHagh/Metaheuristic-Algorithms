function i=TournomentSelection(pop,Tm)

nPop=numel(pop);
s=randsample(nPop,Tm);
spop=pop(s);
scosts=[spop.Cost];
[~, j]=min(scosts);
i=s(j);

end