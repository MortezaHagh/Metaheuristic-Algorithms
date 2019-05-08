function i=Roulettewheel(P)

C=cumsum(P);
r=rand;
i=find(r<=C,1,'first');

end