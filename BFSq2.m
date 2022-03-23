C=[1 2 -1 1];
A=[1 1 -1 3;5 1 4 15];
b=[15;12];

m=size(A,1);
n=size(A,2);

if n>=m
newvar=nchoosek(n,m);
pairs=nchoosek(1:n,m);
S=[];

for i=1:newvar
Y=zeros(n,1);
X=A(:,pairs(i,:))\b;
if all(X>=0 & X~=inf & X~=-inf)
Y(pairs(i,:))=X;
S=[S,Y];
end
end
else
print("Not a B.F.S")
end
