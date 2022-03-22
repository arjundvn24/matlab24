Variables={'x_1','x_2','s_1','s_2','s_3','A_1','A_2','A_3','sol'};
OptVariables={'x_1','x_2','s_1','s_2','s_3','Sol'};

C=[-12 -10 0 0 0 -1 -1 -1 0];
A=[5 1 -1 0 0 1 0 0 10;6 5 0 -1 0 0 1 0 30;1 4 0 0 -1 0 0 1 8];
BV=[5 6 7];

D=[0 0  0 0 0 -1 -1 -1 0];   
StartBV=find(D<0);   

[BFS,A]=simp(A,BV,D,Variables);

A(:,StartBV)=[];  
C(:,StartBV)=[]; 
[OptBFS,OptA]=simp(A,BFS,C,OptVariables);

FINAL_BFS=zeros(1,size(A,2));
FINAL_BFS(OptBFS)=OptA(:,end);
FINAL_BFS(end)=sum(FINAL_BFS.*C);

OptimalBFS=array2table(FINAL_BFS);
OptimalBFS.Properties.VariableNames(1:size(OptimalBFS,2))=OptVariables


function [BFS,A]=simp(A,BV,D,Variables)
    ZjCj=D(BV)*A-D;
    RUN=true;
while RUN
  ZC=ZjCj(1:end-1);
if any(ZC<0)
    fprintf(' The Current BFS is NOT Optimal \n\n')
    [entcol,pvt_col]=min(ZC);
    fprintf('Entering Col=%d \n',pvt_col) ;
    sol=A(:,end);
    Column=A(:,pvt_col);
    if Column<0
        fprintf('Unbounded Solution\n');
    else
        for i=1:size(A,1)
            if Column(i)>0
                ratio(i)=sol(i)./Column(i);
            else
                ratio(i)=inf;
            end
        end
        [MinRatio, pvt_row]=min(ratio);
        fprintf('Leaving Row =%d \n',pvt_row)
        
    end
    BV(pvt_row)=pvt_col;
    pvt_key=A(pvt_row,pvt_col);
    
     A(pvt_row,:)=A(pvt_row,:)./pvt_key;
     for i=1:size(A,1)
         if i~=pvt_row
             A(i,:)=A(i,:)-A(i,pvt_col).*A(pvt_row,:);
         end
     end
    ZjCj=ZjCj-ZjCj(1,pvt_col).*A(pvt_row,:);
    
    ZCj=[ZjCj;A];
    TABLE=array2table(ZCj);
    TABLE.Properties.VariableNames(1:size(ZCj,2))=Variables
    
    BFS(BV)=A(:,end);
else
    RUN=false;
    fprintf('Current BFS is Optimal\n');
    BFS=BV;
end
end
end
