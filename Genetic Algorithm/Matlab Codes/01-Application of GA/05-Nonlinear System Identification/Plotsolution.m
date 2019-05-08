function Plotsolution(sol,model)

t=model.t;

subplot(2,2,1)
plot(t,sol.x1,'r','LineWidth',2)
hold on
plot(t,model.x1,'b:','LineWidth',2)
xlabel('Time')
ylabel('Pray')
legend('Approximation','Main')
hold off

subplot(2,2,3)
plot(t,sol.x2,'r','LineWidth',2)
hold on
plot(t,model.x2,'b:','LineWidth',2)
xlabel('Time')
ylabel('Predator')
legend('Approximation','Main')
hold off

subplot(2,2,[2,4])
plot(sol.x1,sol.x2,'r','LineWidth',2)
hold on
plot(model.x1,model.x2,'b:','LineWidth',2)
xlabel('Pray')
ylabel('Predator')
legend('Approximation','Main')
hold off

end