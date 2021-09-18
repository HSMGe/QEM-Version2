function f_new=garbage_collection(vf,face_status)

nv=numel(vf);
I=vertcat(vf{:}); S=face_status(I);
n=numel(I);
J=zeros(n,1); pos=0;
for i=1:nv
    k=numel(vf{i});
    J(pos+1:pos+k)=i;
    pos=pos+k;
end

del=find(S==-1);
I(del)=[]; J(del)=[];
nf=round(numel(J)/3);
[~,perm]=sort(I);
f_new=reshape(J(perm),3,nf)';