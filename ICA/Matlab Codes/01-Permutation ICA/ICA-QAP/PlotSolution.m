function PlotSolution(p,model)

n=model.n;
m=model.m;
x=model.x;
y=model.y;

Locations=1:m;

A=p;
B=Locations(~ismember(Locations,A));

plot(x(A),y(A),'ks','MarkerSize',14,'MarkerFaceColor','y');
hold on;
plot(x(B),y(B),'bo','MarkerSize',8);

for i=1:n
    text(x(p(i)),y(p(i))-5, num2str(i),'FontWeight','bold');
end

hold off;

end