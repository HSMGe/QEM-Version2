function result=QEM_collapse(id_e)

global v e ve Q_v Cost State New_v edge_status

result=collapse(id_e);
if result
    v2=e(id_e,2);
    v(v2,:)=New_v(id_e,:);
    ve{v2}=ve{v2}(edge_status(ve{v2})~=-1);
    adj_e=ve{v2};
    for i=1:numel(adj_e)
        temp=adj_e(i);
        State(temp)=State(temp)+1;
        v1=e(temp,1); v2=e(temp,2);
        Q=Q_v{v1}+Q_v{v2};
        [error,new_v]=cal_cost(v,e,Q,temp);
        New_v(temp,:)=new_v;
        Cost=priority_queue_push(Cost,[error,temp,State(temp)]);
    end
end