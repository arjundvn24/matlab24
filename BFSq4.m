C=[1 1 1 0 0];
A=[1 1 0 1 0;0 -1 1 0 1];
b=[1;0];

m=size(A,1);
n=size(A,2);

if n>=m
newvar=nchoosek(n,m);
pairs=nchoosek(1:n,m);
S=[];

for i=1:newvar
Y=zeros(n,1)
X=A(:,pairs(i,:))\b;
if (X==0)
Y(pairs(i,:))=X;
S=[S,Y];
end
end
else
print("Not a B.F.S")
end
Y'
