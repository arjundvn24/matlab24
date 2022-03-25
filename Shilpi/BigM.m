% Big M method
clc
clear all
M=1000;

C=[-2 -1 0 0 -M -M  0];
a=[3 1 0 0 1 0 ; 4 3 -1 0 0 1 ; 1 2 0 1 0 0 ];
B=[3;6;3];
artifical_var=[5 6];
A=[a B];
 Var={'x1','x2','s2','s3','A1','A2','sol'};
 s = eye(size(A,1));

 %% Finding starting BFS
 BV = [];
 for j=1:size(s,2)
     for i = 1:size(A,2)
         if A(:,i) == s(:,j)
             BV = [BV i];
         end
     end
 end
 %% Compute zjcj row
zjcj=C(BV)*A - C;
% Display initial simplex table
simplex_table=[zjcj;A];
array2table(simplex_table,'VariableNames',Var)

RUN=true;
 while RUN
if any(zjcj(1:end-1)<0) % check for negative value
 fprintf(' The current BFS is not optimal \n');
 zc=zjcj(1:end-1);
 [Enter_val, pvt_col]= min(zc) ;
 fprintf('The most negative element in zj-cj row is %d corresponding to column %d \n' , Enter_val , pvt_col);
 fprintf('Entering variable is %d \n' , pvt_col);
 if all(A(:,pvt_col)<=0)
  error('LPP is Unbounded');
 else
 sol=A(:,end);
 column=A(:,pvt_col);
  for i=1:size(A,1)
 if column(i)>0
 ratio(i)= sol (i)./column(i);
 else
 ratio(i)=inf;
 end
  end 
  [leaving_value,pvt_row]=min(ratio);
   fprintf('Minimum ratio corresponding to pivot row is %d \n' , pvt_row);
  fprintf('Leaving variable is %d \n' , BV(pvt_row));
 end
 BV(pvt_row)=pvt_col;
 disp('New Basic Variable(BV) = ');
 disp(BV);

  %% Pivot Key
 pvt_key=A(pvt_row, pvt_col);
 A(pvt_row,:)=A (pvt_row,:)./pvt_key;
 % row operation 
for i=1:size(A,1)
 if i~=pvt_row
 A(i,:)=A(i,:)-A (i, pvt_col).*A(pvt_row,:);
 end
end
 zjcj=C(BV)*A-C;
 %% For printing purpose
 next_table=[zjcj; A];
array2table(next_table,'VariableNames',Var)

else
    RUN=false;
    if any(BV==artifical_var(1)) || any(BV==artifical_var(2))
        error('Infeasible solution');
    else
    fprintf('The table is optimal \n');
    end
        Obj_value=zjcj(end);
    fprintf('The final optimal value is % f \n',Obj_value);
end
 end
