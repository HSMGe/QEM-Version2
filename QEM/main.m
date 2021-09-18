filename='D:\obj\Triangle\horse';
target_nv=1000;

global v e vv ve vf vertex_status edge_status face_status Q_v State Cost len New_v

[v,f]=readObj(filename);
subplot(121); drawmesh(f,v);

nv=size(v,1); nf=size(f,1); 

face_status=ones(nf,1);
vertex_status=ones(nv,1);

f_normal=cross(v(f(:,2),:)-v(f(:,1),:),v(f(:,3),:)-v(f(:,1),:),2);
f_normal=f_normal./vecnorm(f_normal,2,2);

he_=sparse(f,[f(:,2),f(:,3),f(:,1)],repmat(1:nf,1,3));

[I,J,~]=find(he_);
vv=accumarray(I,J,[],@(x) {x});

[I,J,F1]=find(triu(he_,1)); [~,~,F2]=find(triu(he_',1));
e=[I,J];

ne=size(e,1);

edge_status=ones(ne,1);

ve_=sparse(e,repmat(1:ne,1,2),1);
[I,J,~]=find(ve_);
ve=accumarray(I,J,[],@(x) {x});

he=zeros(2*ne,2);
he(1:2:end,:)=e; he(2:2:end)=[e(:,2),e(:,1)];

voh_=sparse(he(:,1),1:2*ne,1);
[I,J,~]=find(voh_);
voh=accumarray(I,J,[],@(x) {x});

% vih_=sparse(he(:,2),1:2*ne,1);
% [I,J,~]=find(vih_);
% vih=accumarray(I,J,[],@(x) {x});

vf_=sparse(f,repmat(1:nf,1,3),1);
[I,J,~]=find(vf_);
vf=accumarray(I,J,[],@(x) {x});
% v_normal=accumarray(I,J,[],@(x) {sum(f_normal(x,:))});
% v_normal=vertcat(v_normal{:}); v_normal=v_normal./vecnorm(v_normal,2,2);

Q_v=cell(nv,1);
for i=1:nv
    f_i=vf{i};
    d=-dot(f_normal(f_i,:),repmat(v(i,:),length(f_i),1),2);
    p=[f_normal(f_i,:),d];
    Q_v{i}=p'*p;
end

State=zeros(ne,1);
New_v=zeros(ne,3);
Cost=[];
for i=1:ne
    Q=Q_v{e(i,1)}+Q_v{e(i,2)};
    [error,new_v]=cal_cost(v,e,Q,i);
    New_v(i,:)=new_v;
    Cost=priority_queue_push(Cost,[error,i,0]);
end

QEM(target_nv);
f_new=garbage_collection(vf,face_status);
subplot(122); drawmesh(f_new,v);




