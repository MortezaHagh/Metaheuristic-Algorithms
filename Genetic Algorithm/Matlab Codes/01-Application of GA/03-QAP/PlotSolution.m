function PlotSolution(s,model)

x=model.x;
y=model.y;
n=model.n;

% Assigned Locations
plot(x(s(1:n)),y(s(1:n)),'rs','MarkerSize',12,'MarkerFaceColor','y')
hold on

% UnAssigned Locations
plot(x(s(n+1:end)),y(s(n+1:end)),'bo')

for i=1:n
    text(x(s(i)),y(s(i)),num2str(i),'HorizontalAlignment','center','FontSize',12)
end

hold off
grid on

end