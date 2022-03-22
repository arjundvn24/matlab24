clc
clearall
%%Problem:SolvetheLPPwithGraphicalMethod
%MaximizeZ=2x1+x2,
%Subjectto x1+2x2\le10,
% x1+x2\le6,
% x1-x2\le2,
% x1-2x2\le1,
% x1,x2\geq0
%%Phase1:Insertthecoefficientmatrixandrighthandsidematrix
A=[12;11;1-1;1-2;10;01];
B=[10;6;2;1;0;0];
SmartBoy
%%phase2:Plottingthegraph
P=max(B);
x1=0:1:max(B)
x21=(B(1)-A(1,1).*x1)./A(1,2);
x22=(B(2)-A(2,1).*x1)./A(2,2);
x23=(B(3)-A(3,1).*x1)./A(3,2);
x24=(B(4)-A(4,1).*x1)./A(4,2);
x21=max(0,x21);
x22=max(0,x22)
x23=max(0,x23)
x24=max(0,x24)
E=[x1(:,[A(1,1)A(1,2)])]
%plot(x1,x21,'r',x1,x22,'b',x1,x23,'g',x1,x24,'m');
%title('x1vsx2');
%xlabel('valueofx1');
%ylabel('valueofx2');
%gridon
%holdon
%%phase3:findcornerpointwithaxes,thatislineintercept,or
%findinglineintersectionswithaxes
position_x1=find(x1==0)%pointswithx1axis(indexorposition)
position_x21=find(x21==0)%pointswithx2 axis
Line1=[x1(:,[position_x1position_x21]);x21(:,[position_x1position_x21])]';
SmartBoy
position_x22=find(x22==0)%pointswithx2 axis
Line2=[x1(:,[position_x1position_x22]);x22(:,[position_x1position_x22])]';
position_x23=find(x23==0)%pointswithx2 axis
Line3=[x1(:,[position_x1position_x23]);x23(:,[position_x1position_x23])]';
position_x24=find(x24==0)%pointswithx2 axis
Line4=[x1(:,[position_x1position_x24]);x24(:,[position_x1position_x24])]';
intersection_pts_axes=unique([Line1;Line2;Line3;Line4],'rows')
%%Phase4:findingintersectionoflineswitheachother
pt=[0;0]
fori=1:size(A,1)
A1=A(i,:);%firstconstraintfori=1
B1=B(i,:);
forj=i+1:size(A,1)
A2=A(j,:);%secondconstraintfori+1=j=2
B2=B(j,:);
A4=[A1;A2];
B4=[B1;B2];
X=A4\B4%inverseofmatrix
pt=[ptX]
end
end
ptt=pt'
SmartBoy
%%
% %%Phase5:Writeallcornerpoints
cor_pts=[intersection_pts_axes;ptt]
P=unique(cor_pts,'rows')
size(P)
%%
% %%Phase6:Feasibleregionpoints
b1=P(:,1);%writefirstcolumnofmatrix
b2=P(:,2);
%%%write1stConstraint%allconstraintsareof<=sign
cons1=round(b1+(2.*b2)-10);
s1=find(cons1>0);
P(s1,:)=[];
%%%%write2ndConstraint%allconstraintsareof<=sign
b1=P(:,1);
b2=P(:,2);
cons2=round((b1+b2)-6);
s2=find(cons2>0);
P(s2,:)=[];
%%%write3rdConstraint%allareof<=sign
b1=P(:,1);
b2=P(:,2);
cons3=round((b1-b2)-2);
s3=find(cons3>0);
SmartBoy
P(s3,:)=[];
%%%write4thConstraint%allareof<=sign
b1=P(:,1);
b2=P(:,2);
cons4=round((b1-(2.*b2))-1);
s4=find(cons4>0);
P(s4,:)=[];
%%%write5thConstraint%allareof<=sign
b1=P(:,1);
b2=P(:,2);
cons5=round(-b1);
s5=find(cons5>0);
P(s5,:)=[];
%%%write6thConstraint%allareof<=sign
b1=P(:,1);
b2=P(:,2);
cons6=round(-b2);
s6=find(cons6>0);
P(s6,:)=[];
f_points=P
%
%%
%%%Phase7:Objectivefunctionvalue
c=[2,1];
SmartBoy
fori=1:size(P,1)
fn(i,:)=(sum(P(i,:).*c));
optim=max(fn)
en