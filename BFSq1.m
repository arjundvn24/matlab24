C=[1 2 0 0];
A=[-1 2 1 0;1 1 0 1];
b=[1;2];

m=size(A,1);
n=size(A,2);

if n>=m
number_of_pairs=nchoosek(n,m);
pairs=nchoosek(1:n,m);
S=[];
for i=1:number_of_pairs
Y=zeros(n,1);
X=A(:,pairs(i,:))\b;
if all(X>=0 & X~=inf)
Y(pairs(i,:))=X;
S=[S,Y];
end
end
else
print("Not a B.F.S")
end
S'