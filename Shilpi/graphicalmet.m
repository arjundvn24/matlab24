%% Graphical Method
%%Step 1: Input Parameters
C=[3 2]; %% Objective function
A=[2 4;3 5]; %%Constraints
B=[8;15];

%%Step 2: Plotting of Graph
x1 = 0:1:max(B);
x21 = (B(1)-A(1,1).*x1)./A(1,2);
x22 = (B(2)-A(2,1).*x1)./A(2,2);
x21=max(0,x21);
x22=max(0,x22);
plot(x1,x21,'r',x1,x22,'b');
xlabel('Value of x1');
ylabel('Value of x2');
title('x1 Vs x2');
legend('2x1+4x2=8','3x1+5x2=15');
grid on;

%%Step 3:Finding corner points with the axes
cx1= find(x1==0);
c1= find(x21==0);
Line1=[x1(:,[c1,cx1]); x21(:,[c1,cx1])]';

c2= find(x22==0);
Line2=[x1(:,[c2,cx1]); x22(:,[c2,cx1])]';
cornerpoint=unique([Line1;Line2],'rows');
%%Step 4: Intersection Points
GM=[];
for i=1:size(A);
    con1 =A(i,:);
    b1=B(i);
    for j=i+1:size(A);
        con2=A(j,:);
        b2=B(j);
        Aa=[con1;con2];
        Bb=[b1;b2];
        X= Aa\Bb;
        GM=[GM X];
    end
end
pt=GM';

%%Write all the corner points
allpoints = [pt;cornerpoint];
points=unique(allpoints,'rows')

%%Step 6:Find the Feasible Region
for i=1:size(points,1)
    const1(i)=A(1,1)*points(i,1)+A(1,2)*points(i,2) - B(1); %% <=sign
    const2(i)=A(2,1)*points(i,1)+A(2,2)*points(i,2) - B(2); %% <=sign
end
s1=find(const1>0);
s2=find(const2>0);
S=unique([s1 s2]);
points(S,:)=[];
%%Step 7:Compute objective function
value = points*C';
table =[points value];
%%Step 8: Find the optimal Solution
[obj,index]=max(value);
x1 =points(index,1);
x2 =points(index,2);
fprintf('Objective function value is %d at(%d,%d)\n',obj,x1,x2);




