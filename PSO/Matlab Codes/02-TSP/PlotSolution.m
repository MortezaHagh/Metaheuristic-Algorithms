function PlotSolution(tour,model)

x=model.x;
y=model.y;

plot(x(tour),y(tour),'b-s', 'linewidth',2,'MarkerSize',12,...
    'MarkerFaceColor','y');

end