function bad = eval_disp(disp, gt)
%returns the percentage of pixels where disp is wrong. disp is predicted disparity, gt is ground truth disparity. Assumes that gt is 0 where there is no ground truth

i1=find(gt~=0);
gt=double(gt);
bad=sum(abs(disp(i1)-gt(i1))>1)/length(i1);
