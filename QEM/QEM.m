function QEM(target_nv)

global v Cost State

nv=size(v,1);
nv_new=min(target_nv,1000);

tic;
while nv>nv_new
    c=Cost(1,:);
    Cost=priority_queue_pop(Cost);
    if State(c(2))==c(3)
        if QEM_collapse(c(2))
            nv=nv-1;
        end
    end
end
toc;