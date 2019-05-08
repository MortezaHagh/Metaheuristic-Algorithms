function [y1, y2]=Crossover_Arithmetic(x1, x2, gama, VarMin, VarMax)

alpha=unifrnd(-gama,1+gama,size(x1));

y1=x1.*alpha+x2.*(1-alpha);
y2=x2.*alpha+x1.*(1-alpha);

y1=max(y1, VarMin);
y1=min(y1, VarMax);

y2=max(y2, VarMin);
y2=min(y2, VarMax);

end