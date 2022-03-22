format short
c=[-1 2 ];
A=[-1 1;1 1];
B=[1;2];
m=size(A,1);
n=size(A,2);
nv=nchoosek(n,m);
t=nchoosek(1:n,m);
sol=[];
if n>=m
    disp("in")
for i=1:nv
    y=zeros(n,1);
    x=A(:,t(i,:))\B;
    if all(x>=0 & x~=inf & x~=-inf)
    y(t(i,:))=x;
    sol=[sol y];
    end
end
else
    error('Equation is large than variable')
end
Z=c*sol;
[Zmax, Zind]=max(Z);
BFS=sol(:,Zind);
optval=[BFS' Zmax];
OPTIMAL_BFS=array2table(optval);
OPTIMAL_BFS.Properties.VariableNames(1:size(OPTIMAL_BFS,2))={'x_1','x_2','Z'}