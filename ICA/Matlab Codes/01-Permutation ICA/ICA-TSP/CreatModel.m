function model=CreatModel()

% Cities x & y Location
x=[31 36 93 22 7 34 5 9 99 84 33 3 70 61 66 31 75 50 72 4];
y=[62 21 27 75 99 55 1 93 89 28 32 60 49 20 72 86 13 39 87 3];
n=numel(x); % Num of Cities

% Distance Matrix
d=zeros(n,n);
for i=1:n-1
    for j=i+1:n
        d(i,j)=sqrt((x(i)-x(j))^2+(y(i)-y(j))^2);
        d(j,i)=d(i,j);
    end
end

model.n=n;
model.x=x;
model.y=y;
model.d=d;

end