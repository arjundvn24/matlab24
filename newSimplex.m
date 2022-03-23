format short 
clear all
clc
%% Input Parameters
c=[50 60];
novar=2;
info=[2,3;3,3;1 0;0 1];
b=[1500;1500;400;400];
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
    fprintf('themost positive is%d with col %D', entercol,pvtcol);
    fprintf('entering variable is %d \n',pvtcol);
    
    %finding the leaving variable 
    sol=A(:,end)
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
    bfs1=zeros(1,size(A,2));
    bfs1(bv)=A(:,end);
    bfs1(end)=sum(bfs1.*cost);
    disp("x1= "+bfs1(1,1))
    disp("x2= "+bfs1(1,2))
    disp("solution= "+bfs1(1,7))
else
    run=false;
    fprintf(' current bfs is optimal ')
    disp('optimal solution reached')
end

end