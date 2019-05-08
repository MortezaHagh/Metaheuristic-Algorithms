clc
clear
close all

model=CreateModel();
t=model.t;
x1=model.x1;
x2=model.x2;

figure;
subplot(2,1,1)
plot(t,x1,'r','LineWidth',2)
hold on
plot(t,x2,'b:','LineWidth',2)
xlabel('Time')
legend('Pray','Predator')

subplot(2,1,2)
plot(x1,x2,'k','LineWidth',2)
xlabel('Pray')
ylabel('Predator')
