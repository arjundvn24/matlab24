%step 1 start
C=[2 3 4 7];
A=[2 3 -1 4; 1 -2 6  -7 ];
B=[8;-3];
%step 1 over
%step 2 no of rows and columns
m=size(A,1);%number of rows
n=size(A,2);%number of columns
if n>=m
%step 3 pairs
nCm=nchoosek(n,m);%no of pairs
t=nchoosek(1:n,m);%pairs get formed
%step 4 Find bfs
sol=[];
for i=1:nCm
y=zeros(n,1);
x=A(:,t(i,:))\B; %all rows,particular column, A-1*B
if(x>=0 & x~=inf & x~=-inf)
    y(t(i,:))=x;
    sol=[sol y];
end
end
else
    fprintf("Equations are larger than variables");
end
%step 5 compute the objective function
Z=C*sol;
%step 6 find the optimal solution (maximum Z)
[Zmax,Zind]=max(Z);
basic=sol(:,Zind);
%step 7 print the solution
optval=[basic' Zmax];
H1=array2table(optval,'VariableNames',{'x1','x2','x3','x4','Z'});

   




