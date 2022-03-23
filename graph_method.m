C=[3 2];
A=[2 4;3 5];
B=[8;15];
y=0:1:15;
x21 = (B(1)-A(1,1).*y)./A(1,2);
x22 = (B(2)-A(2,1).*y)./A(2,2);
x21 = max(0,x21);
x22 = max(0,x22);
plot(y,x21,y,x22);
xlabel("x1");
ylabel("x2");
title("x1 versus x2");
legend("2x1+4x2=8","3x1+5x2=15");
grid on;
cx1 = find(y==0);
c1 = find(x21==0);
Line1=[y(:,[c1 cx1]); x21(:,[c1 cx1])]';
c2 = find(x22==0);
Line2 = [y(:,[c2 cx1]);x22(:, [c2 cx1])]';
cornerpt = unique([Line1; Line2],'rows');
SS = [0;0];
for i = 1:size(A,1) 
    A1 = A(i,:);
    B1 = B(i,:);
    for j = i + 1 : size(A, 1)
        A2 = A(j,:);
        B2 = B(j,:);
        A3 = [A1;A2];
        B3 = [B1;B2];
        Xx = A3\B3;
        SS = [SS Xx];
    end
end
pt = SS';

allpt = [pt;cornerpt];
points = unique(allpt,'rows');

PT = constraint(points);
PT = unique(PT, 'rows');
Fx=zeros(1);
for i = 1 : size(PT, 1)
    Fx(i,:)= sum(PT(i,:).*C);
end
Vert_Fns = [PT Fx];

[fxval, indfx] = max(Fx);
optval = Vert_Fns(indfx,:);
OPTIMAL_BFS = array2table(optval)

