function out = constraint2(X)
x1 = X(:,1);
x2 = X(:,2);
cons1 = 2*x1+4*x2-8; 
h1 = find(cons1 < 0);
X(h1,:) = [];

x1 = X(:, 1);
x2 = X(:, 2);
cons2 = 3*x1+5*x2-15; 
h2 = find(cons2 < 0);
X(h2, :) = [];

x1 = X(:, 1);
x2 = X(:, 2);
cons3 = x2 - 600; 
h3 = find(cons3 > 0);
X(h3, :) = [];

out = X;
end