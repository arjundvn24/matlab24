%step 1 write all matrices according to equation
A=[3 -1 2;-2 4 0;-4 3 8];
B=[7;12;10];
C=[-1 3 -2 0 0 0 0];
%step 2 introducing slack surplus variable
n=size(A,1); %Number of rows
s=eye(n);
matrix=[A s B];
bv=n+1:size(matrix,2)-1;%construct/selecting Basic variable
zjcj=C(bv)*matrix-C;%basic variable ke coefficent chaiya hai cost vector vale
p=[zjcj;matrix];
H1=array2table(p,'VariableNames',{'x1','x2','x3','s1','s2','s3','B'});
disp(H1);
run=true;
while run
%%most negative among Zj-Cj (enetering )
if any(zjcj(1:end-1)<0)
    fprintf("The optimal solution is not attained \n");
    zc=zjcj(1:end-1);
    [entercol,pivotcol]=min(zc);
    fprintf("The most negative element in Zj-Cj row is %d corresponding to column %d \n",entercol,pivotcol);
    fprintf("Entering variable is %d \n ",pivotcol);
if all(matrix(:,pivotcol)<0)
    fprintf("Error ->LPP is unbounded");
else
    %%Finding the leaving variable (min ratio)
    sol=matrix(:,end);
    column=matrix(:,pivotcol);
    for i=1:size(matrix,1)
        if column(i)>0
            ratio(i)=(sol(i)./column(i));
        else
            ratio(i)=inf;
        end
    end
[leavingvar,pivotrow]=min(ratio);
fprintf("Minimum ratio corresponding to pivot row is %d \n",pivotrow);
fprintf("Leaving variable is %d \n",bv(pivotrow));%bv(pivotrow) direct use karke update kar rahe hain bv mein
end
bv(pivotrow)=pivotcol;%interchange
disp("New Basic variable(BV)=");
disp(bv);
%% computing pivot key
pivotkey = matrix(pivotrow,pivotcol);
%% update the table for next iteration
matrix(pivotrow,:)=(matrix(pivotrow,:)./pivotkey);%%pivot element ko 1 ban rahe hain for new table
%%row operations
for i=1:size(A,1)
    if i~=pivotrow
        matrix(i,:)=matrix(i,:)-matrix(i,pivotcol)*matrix(pivotrow,:);
    end
end
zjcj=C(bv)*matrix-C;
%%printing the table
simplextable=[zjcj;matrix];
st=array2table(simplextable,'VariableNames',{'x1','x2','x3','s1','s2','s3','B'});
disp(st);
else
    run=false;
    fprintf("The table is optimal \n");
    Obj_value=zjcj(end);
    fprintf('The final optimal value is %f \n',Obj_value);
end
end







