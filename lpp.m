format short
clc

c=[3 2];
A=[2,4;3,5;1,0;0,1];
b=[8;15;0;0];

y1=0:1:max(b);
x21=(b(1)-A(1,1).*y1)./A(1,2);
x22=(b(2)-A(2,1).*y1)./A(2,2);

x21=max(0,x21);
x22=max(0,x22);
plot(y1, x21, 'r' ,y1, x22, 'k');
xlabel('Value of x1');
ylabel('Value of x2');
title('x1 vs x2')
legend('2x+4x2=8','3x1+5x2=15')
grid on
    cx1 = find(y1 == 0);
        c1 = find(x21 == 0);
Line1 = [y1(:,[c1 cx1]) ; x21(:,[c1 cx1])]';
        c2 = find(x22 == 0);
Line2 = [y1(:,[c2 cx1]) ; x22(:,[c2 cx1])]';

corpt = unique([Line1 ; Line2],'rows');