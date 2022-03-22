% Z = 3x1 + 5x2
% x1 + 2x2 <= 2000
% x1 + x2 <= 1500
% x2 <= 600
% x1, x2 >= 0


format long
clc
% C = input("Enter the Cost vector: \n");
% disp(C);
% A = input("Enter the Cofficient matrix of Constraints: \n");
% disp(A);
% B = input("Enter the solution matrix of Constraints");
% disp(B);

C = [3 5];
A = [1 2; 1 1; 0 1];
B = [2000; 1500; 600];

y1 = 0 : 1 : max(B);
x21 = (B(1) - A(1, 1) .* y1) ./ A(1, 2);
x22 = (B(2) - A(2, 1) .* y1) ./ A(2, 2);
x23 = (B(3) - A(3, 1) .* y1) ./ A(3, 2);

x21 = max(0, x21);
x22 = max(0, x22);
x23 = max(0, x23);
plot(y1, x21, 'k', y1, x22, 'r', y1, x23, 'b');
xlabel("Value of x1");
ylabel("Value of x2");
title("x1 vs x2");
legend("x1 + 2x2 = 2000", "x1 + x2 = 1500", "x2 = 600");
grid on;

cx1 = find(y1 == 0);
c1 = find(x21 == 0);
Line1 = [y1(:, [c1 cx1]); x21(:, [c1 cx1])]';

c2 = find(x22 == 0);
Line2 = [y1(:, [c2 cx1]); x22(:, [c2 cx1])]';

c3 = find(x23 == 0);
Line3 = [y1(:, [c3 cx1]); x23(:, [c3 cx1])]';

corpt = unique([Line1; Line2; Line3], 'rows');

HG = [0; 0];
for i = 1 : size(A, 1)
    hg1 = A(i, :);
    B1 = B(i, :);
    for j = i + 1 : size(A, 1)
        hg2 = A(j, :);
        B2 = B(j, :);
        Aa = [hg1 ; hg2];
        Bb = [B1; B2];
        Xx = Aa \ Bb;
        HG = [HG Xx];
    end
end
pt = HG';

allpt = [pt; corpt];
points = unique(allpt, 'rows');

PT = constraint(points);
PT = unique(PT, 'rows');


for i = 1 : size(PT, 1)
    Fx(i, :) = sum(PT(i, :) .* C);
end
Vert_Fns = [PT Fx];

[fxval, indfx] = max(Fx);
optval = Vert_Fns(indfx, :);
OPTIMAL_BFS = array2table(optval);
disp(OPTIMAL_BFS);