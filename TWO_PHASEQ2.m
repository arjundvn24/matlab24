V1={'x1','x2','s1','s2','s3','A1','A2','A3','Sol'};
V2={'x1','x2','s1','s2','s3','Sol'};

C1=[-12 -10 0 0 0 1 1 1 0];
A=[5 1 -1 0 0 1 0 0 10;
    6 5 0 -1 0 0 1 0 30;
    1 4 0 0 -1 0 0 1 8];

BV=[7 8 9];

IC=[0 0 0 0 0 -1 -1 -1 0];   
IBV=find(IC<0);   
fprintf('PHASE-1\n');
[BFS,A]=TWO_PHASE(A,BV,IC,V1);

fprintf('PHASE-2\n');
A(:,IBV)=[]; 
C1(:,IBV)=[];
[OptBFS,OptA]=TWO_PHASE(A,BFS,C1,V2);

TRUE_BFS=zeros(1,size(A,2));
TRUE_BFS(OptBFS)=OptA(:,end);
TRUE_BFS(end)=sum(TRUE_BFS.*C1);

OBFS=array2table(TRUE_BFS);
OBFS.Properties.VariableNames(1:size(OBFS,2))=V2

function [BFS,A]=TWO_PHASE(A,BV,D,Variables)
    ZjCj=D(BV)*A-D;
    RUN=true;
while RUN
  ZC=ZjCj(1:end-1);
if any(ZC<0); 
    fprintf(' BFS NOT OPTIMAL \n')
 
    [entcol pvt_col]=min(ZC);
   
    S=A(:,end);
    C1=A(:,pvt_col);
    if C1<0
        fprintf('REGION UNBOUNDED\n');
        break;
    else
        for i=1:size(A,1)
            if C1(i)>0
                ratio(i)=S(i)./C1(i);
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
else RUN=false;
    fprintf('BFS OPTIMAL\n');
    fprintf('Phase-1 END\n');
    BFS=BV;
end
end
end