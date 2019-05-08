clc
clear
close all

params.T=25;
params.dt=0.001;

params.x10=2;
params.x20=1;

params.a=1.2;
params.b=0.6;
params.c=0.8;
params.d=0.3;

out=SimulateModel(params);
t=out.t;
x1=out.x1;
x2=out.x2;

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
