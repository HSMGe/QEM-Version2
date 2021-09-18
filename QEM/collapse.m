function result=collapse(id_e)

global e vv ve vf vertex_status edge_status face_status

if edge_status(id_e)==-1
    result=false;
    return;
end

v1=e(id_e,1); v2=e(id_e,2);
v_temp=intersect(vv{v1},vv{v2});
v_valid=vertex_status(v_temp)~=-1;
v_temp=v_temp(v_valid);
if numel(v_temp)~=2
    result=false;
    return;
else
    result=true;
end

if result
    vv{v2}=setdiff([vv{v1};vv{v2}],[v1,v2]);
    vv{v1}=vv{v1}(vertex_status(vv{v1})~=-1);
    v_test=vv{v1};
    for i=1:numel(v_test)
        vv{v_test(i)}(vv{v_test(i)}==v1)=v2;
    end
    vv{v1}=[];
    vertex_status(v1)=-1;
    
    f_delete=intersect(vf{v1},vf{v2});
    vf{v2}=setdiff([vf{v1};vf{v2}],f_delete);
    vf{v1}=[];
    face_status(f_delete)=-1;
    
    temp=e(ve{v1},:);
    [m,~]=find(temp==v_temp(1)|temp==v_temp(2));
    e_temp=ve{v1}(m);
    e_delete=[id_e;e_temp];
    edge_status(e_delete)=-1;
    temp(temp==v1)=v2;
    e(ve{v1},:)=temp;
    ve{v2}=setdiff([ve{v1};ve{v2}],e_delete);
    ve{v1}=[];
end