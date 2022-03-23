var = {'x1','x2','s1','s2','s3','A1','A2','A3','Sol'};
M = 5000;
cost = [-12 -10 0 0 0 -M -M -M 0];
A = [5 1 -1 0 0 1 0 0 10;
    6 5 0 -1 0 0 1 0 30
    1 4 0 0 -1 0 0 1 8];
s = eye(size(A,1));
BasicVar=[];
for x=1:size(s,2)
    for y=1:size(A,2)
        if A(:,y)==s(:,x)
            BasicVar =[BasicVar y];
        end
    end
end
B = A(:,BasicVar);
A = inv(B)*A;
ZjCj = cost(BasicVar)*A -cost;
ZCj=[ZjCj;A];

SimpTable = array2table(ZCj);
SimpTable.Properties.VariableNames(1:size(ZCj,2)) = var;

RUN = true;
while RUN
ZC = ZjCj(:,1:end-1);
if any(ZC<0);
    fprintf('The current BFS is not optimal \n');
 
    [Enterval, pvt_col] = min(ZC);
    fprintf('Entering Column = %d\n',pvt_col);
    
    sol = A(:,end);
    Column = A(:,pvt_col);
    if all(Column)<=0
        fprintf('Solution is unbounded \n');
    else
        imp = find(Column>0);
        ratio = inf.*ones(1,length(sol));
        ratio(imp) = sol(imp)./Column(imp);
        
        for y=1:size(Column,1)
            if Column(y)>0
                ratio(y)=sol(y)./Column(y);
            else
                ratio(y)=inf;
            end
        end
        
        [minR,pvt_row]=min(ratio);
        fprintf('Leaving Row - %d \n',pvt_row);
        
        BasicVar(pvt_row)=pvt_col;
        B = A(:,BasicVar);
        A = inv(B)*A;
        ZjCj = cost(BasicVar)*A - cost
        
        
        
        ZCj=[ZjCj;A];

        Table = array2table(ZCj);
        Table.Properties.VariableNames(1:size(ZCj,2)) = var;
    end
   
    else
        RUN = false;
        fprintf(' Current BFS is optimal \n');
    end
end