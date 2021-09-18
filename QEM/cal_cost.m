function [error,new_v]=cal_cost(v,e,Q,k)

% v - vertices
% e - edges
% Q - error matrix
% k - edge ID

% global Q_e New_v

Q_=Q; Q_(4,:)=[0,0,0,1];
if det(Q_)==0
    new_v=sum(v(e(k),:))/2;
    temp=[new_v,1];
else
    temp=Q_\[0;0;0;1];
    new_v=temp(1:3);
end

% New_v(k,:)=new_v;
error=temp'*Q*temp;