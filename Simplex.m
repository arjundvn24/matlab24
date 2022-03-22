format short 
clear 
clc
%% Input Parameters
c=[4,6,3,1];
novar=4;
info=[1,4,8,6;4,1,2,1;2,3,1,2];
b=[11;7;2];
s=eye(size(info,1));
A=[info s b];
%% telling number of columns
cost=zeros(1,size(A,2));
cost(1:novar)=c;
%% line 15 represented as start:gap:end(finding column number of s1,s2,s3)
%% bv=number of basic variables
bv=novar+1:1:size(A,2)-1;
%% zjcj = zj-cj
zjcj=cost(bv)*A-cost;
zcj=[zjcj;A];
%% printing whole table
simtab=array2table(zcj);
%% changing title headers
simtab.Properties.VariableNames(1:size(zcj,2))={'x_1','x_2','x_3','x_4','s_1','s_2','s_3','sol'}
run=true;
while run
%% simplex table begin here 
if any(zjcj<0); %% if answer is negative then we will find entering variable
    fprintf('\n  not optimal bfs ')
    fprintf('\n the next iteration \n')
    disp('old bfs variable BV -');
    disp(bv);
    %% finding entering variable 
    zc=zjcj(1:end-1);
    
    [entercol, pvtcol]=min(zc);
    fprintf('the most negative is%d with col %D', entercol,pvtcol);
    fprintf('entering variable is %d \n',pvtcol);
    
    %finding the leaving variable 
    sol=A(:,end);
    column=A(:,pvtcol);
    if all(column<=0)
        error('lpp is unbounded ',pvtcol);
    else
        for i=1:size(column,1)
            if column(i)>0
                ratio(i)=sol(i)./column(i)
            else
                ratio(i)=inf;
            end
        end
        [minratio,pvtrow]=min(ratio);
        fprintf('minimum ratio is %d',pvtrow);
        fprintf(' leaving variable is %d \n',bv(pvtrow));
    end
    bv(pvtrow)=pvtcol;
    disp('new basic variable (bv) ');
    disp(bv);
    %% pivot key(pivot is common element in both row and column)
    pvtkey=A(pvtrow,pvtcol);
    A(pvtrow,:)=A(pvtrow,:)./pvtkey;
    for i=1:size(A,1)
        if i~=pvtrow
            A(i,:)=A(i,:)-A(i,pvtcol).*A(pvtrow,:);
        end
   end
    zjcj=zjcj-zjcj(pvtcol).*A(pvtrow,:);
    zcj=[zjcj;A];
    table=array2table(zcj);
    table.Properties.VariableNames(1:size(zcj,2))={'x_1','x_2','x_3','x_4','s_1','s_2','s_3','sol'}
    
    bfs1=zeros(1,size(A,2));
    bfs1(bv)=A(:,end);
    bfs1(end)=sum(bfs1.*cost);
    current_bfs=array2table(bfs1);
    current_bfs.Properties.VariableNames(1:size(current_bfs,2))={'x_1','x_2','x_3','x_4','s_1','s_2','s_3','sol'}
    
    
else
    run=false;
    fprintf(' current bfs is optimal ')
    disp('optimal solution reached')
end

end