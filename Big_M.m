clc
clear all

%inputting the information
num_var = 3; %the number of variables
a = [ 1 1 2; 2 3 4 ]; %coeff
b = [5 ; 12]; %RHS
c = [2 1 3]; %cost in optimisation function
s = eye(size(a , 1));
A = [a s b];
cost = zeros(1,size(A , 2));
cost(1:num_var) = c;
%M = inf;
M = 10000;
cost(num_var+1:1:size(A,2)-1) = [0  -M];
basic_variables = num_var+1:1:size(A,2)-1;
% CB  = cost(basic_variables);
ZJ_CJ = (cost(basic_variables)*A) - cost;
ZC = [ZJ_CJ; A];
%copying our array into a table to make it easier to handle as they have
%labels on ech column
%tables - Each column can have different data types
Otable = array2table(ZC);
Otable.Properties.VariableNames(1:size(ZC,2)) = {'x1','x2','x3','s1','A1', 'sol'};

runner = true;
while runner
    if any(ZJ_CJ < 0)
        disp("NOT OPTIMAL");
        disp("Basic Variavbles");
        disp(basic_variables);
        ZC = ZJ_CJ(1:end -1);
        
        [e_col , key_col] = min(ZC);
        fprintf('the most negative is%d with col %D', e_col,key_col);
        fprintf('entering variable is %d \n',key_col);
        
        %finding the solution vector
        sol = A(:,end);
        column = A(:,key_col);
        if all(column<=0)
        printf('lpp is unbounded ',key_col);
        else
        for i=1:size(column,1)
            if column(i)>0
                ratio(i)=sol(i)./column(i);
            else
                ratio(i)=inf;
            end
        end
        [minratio,pvtrow]=min(ratio);
        fprintf('minimum ratio is %d',pvtrow);
        fprintf(' leaving variable is %d \n',basic_variables(pvtrow));
        end
    basic_variables(pvtrow) = key_col;
    disp('new basic variable (bv) ');
    disp(basic_variables);
    pvtkey=A(pvtrow,key_col);
    A(pvtrow,:)=A(pvtrow,:)./pvtkey;
    for i=1:size(A,1)
        if i~=pvtrow
            A(i,:)=A(i,:)-A(i,key_col).*A(pvtrow,:);
        end
    end
    ZJ_CJ=ZJ_CJ-ZJ_CJ(key_col).*A(pvtrow,:);
    ZC=[ZJ_CJ;A];
    table=array2table(ZC);
    table.Properties.VariableNames(1:size(ZC,2))={'x_1','x_2','x_3','s_1','A1','sol'};
   
    bfs1=zeros(1,size(A,2));
    bfs1(basic_variables)=A(:,end);
    bfs1(end)=sum(bfs1.*cost);
    current_bfs=array2table(bfs1);
    current_bfs.Properties.VariableNames(1:size(current_bfs,2))={'x_1','x_2','x_3','s_1','A1','sol'};
    
    else
        runner = false;
        disp('current bfs is optimal');
        disp(sol);    
    end
end
