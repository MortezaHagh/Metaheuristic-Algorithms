function plotSolution(sol,model)

ST=sol.ST;
FT=sol.FT;
n=model.n;
Cmax=sol.Cmax;
h=1;
Colors=hsv(n);

for i=1:n
    X=[ST(i) FT(i)  FT(i) ST(i)];
    Y=[0 0 h h];
    fill(X,Y,Colors(i));
    hold on
    xm=(ST(i)+FT(i))/2;
    ym=h/2;
    text(xm,ym,num2str(i),'HorizontalAlignment','center','FontWeight','bold','FontSize',13);
end

plot([Cmax Cmax],[0 2*h],'r:','Linewidth',2)
title(['C_{max}  =   ' num2str(Cmax)]);
hold off
ylim([0 2*h]);

end
