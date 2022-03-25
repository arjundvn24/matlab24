%Step 1 : Input the variables%
C=[3 2];
A=[1 2; 1 1; 1 -1];
B=[10; 6; 1];
%Step 2: Introduce the surplus and slack variables%
n=size(A,1); %Number of rows
s=eye(n);
sign=[0 0 1]; %0 for <= sign ,1 for >= sign
index=find(sign>0);
s(index,:)=-s(index,:);
matrix=[A s];
%Step 3: Write the standard form
H=array2table(C,'VariableNames',{'x1','x2'}); %to convert into tabluar form
H1=array2table(matrix,'VariableNames',{'x1','x2','s1','s2','s3'});

