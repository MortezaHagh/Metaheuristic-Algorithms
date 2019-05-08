function model=CreatModel()

% Communicating Weight
w = [0    38    13    37    30    33    41    21
    38     0    27    34    30    36    43    24
    13    27     0    19    22    28    38    28
    37    34    19     0    29    30    22    40
    30    30    22    29     0    20    30    32
    33    36    28    30    20     0    17    32
    41    43    38    22    30    17     0    20
    21    24    28    40    32    32    20    0];

n=size(w,1);    % Num of Facilities

% Locations x & y
x=[94 13 57 47 1 34 16 80 31 53 16 60 26 66 69 75 45 8 23 92 15 83 54 100 7 44 10 97 0 78];
y=[82 87 8 40 26 80 43 91 18 26 14 13 87 58 55 14 86 62 35 51 40 7 24 12 18 24 42 5 91 95];
m=numel(x);    % Num of Locations

% Distance Matrix
d=zeros(m,m);
for i=1:m-1
    for j=i+1:m
        d(i,j)=sqrt((x(i)-x(j))^2+(y(i)-y(j))^2);
        d(j,i)=d(i,j);
    end
end

model.n=n;
model.m=m;
model.w=w;
model.d=d;
model.x=x;
model.y=y;

end