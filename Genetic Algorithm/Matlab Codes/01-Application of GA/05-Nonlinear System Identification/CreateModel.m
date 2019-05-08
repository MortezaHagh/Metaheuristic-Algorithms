function model=CreateModel()

model.T=25;
model.dt=0.002;

model.x10=2;
model.x20=1;

model.a=1.2;
model.b=0.6;
model.c=0.8;
model.d=0.3;

out=SimulateModel(model);
model.t=out.t;
model.x1=out.x1;
model.x2=out.x2;

end
