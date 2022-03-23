C = [3 2];
A = [2 4; 3 5];
B = [8; 15];
y1 = 0:1:max(B);
x21 = (B(1) - A(1,1).*y1)./A(1,2);
x22 = (B(2) - A(2,1).*y1)./A(2,2);
x21 = max(0,x21);
x22 = max(0,x22);
plot(y1,x21,'r',y1,x22,'b')
xlabel('Value of x1');
ylabel('Value of x2');
title('x1 Vs x2')
legend('2x1 + 4x2 = 8','3x1 + 5x2 = 15')
grid on
cx1 = find(y1==0); 
c1 = find(x21==0); 
Line1 = [y1(:,[c1 cx1]) ; x21(:,[c1 cx1])]';
c2 = find(x22==0); 
Line2 = [y1(:,[c2 cx1]) ; x21(:,[c2 cx1])]';
corpt = unique([Line1; Line2],'rows');
H = [0;0];
for i=1:size(A,1) 
    A1 = A(i,:);
    B1 = B(i,:);
    for j=i+1:size(A,1)
        A2 = A(j,:);
        B2 = B(j,:);
        A3 = [A1;A2];
        B3 = [B1;B2];
        t = (inv(A3))*B3;
        H = [H;t];
    end
end
pt = H';
allpt = [pt;corpt];
points = unique(allpt,'rows');

P = constraint(points);
P = unique(P,'rows');
for i=1:size(P,1)
    F(i,:) = sum(P(i,:).*C);
end

Fun = [P,F];
[f,g] = max(F);
opt = Fun(g,:);
OPT = array2table(opt);