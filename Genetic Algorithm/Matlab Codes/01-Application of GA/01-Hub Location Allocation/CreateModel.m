function model=CreateModel()

% Customers Data
xc=[12 12 12 15 77 3 21 0 3 5 47 95 81 5 19 96 36 58 37 43 34 25 75 65 89 22 71 36 4 84 75 24 20 66 27 84 71 37 4 77];
yc=[31 66 74 63 38 68 55 4 81 93 67 81 31 40 21 37 85 42 57 75 42 80 90 98 28 34 31 50 8 49 94 19 67 19 13 74 65 36 93 4];
dc=[13 50 44 6 24 9 18 5 27 14 29 24 31 31 18 35 14 14 10 45 23 12 24 5 11 30 29 21 35 27 26 20 15 26 50 9 15 26 49 42];
N=numel(xc);

% Server Data
xs=[85 78 18 9 86 86 7 44 73 77 41 6 42 58 78 48 84 83 2 97];
ys=[39 3 19 63 52 49 84 16 73 40 40 33 41 55 64 79 25 20 56 19];
cs=[11243 8647 11029 8745 10192 10921 10411 9060 10430 8635 8127 11813 9090 10691 8081 8459 10938 11797 11954 9444];
M=numel(xs);

D=zeros(N,M);
for i=1:N
    for j=1:M
        D(i,j)=norm([xc(i)-xs(j) yc(i)-ys(j)],1);
    end
end
w1=1;
w2=1;

model.xc=xc;
model.yc=yc;
model.dc=dc; % Demand
model.N=N;

model.D=D;

model.xs=xs;
model.ys=ys;
model.cs=cs; % Setup Cost
model.M=M;

model.w1=w1;
model.w2=w2;

end