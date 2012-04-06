function [dispL dispR err] = goDisparity(imgName, neigh, method, cocc)

%% Load Images
Ileft = imread(['../data/' imgName '/left.png']);
Iright = imread(['../data/' imgName '/right.png']);
gt = load(['../data/' imgName '/gt.mat']);
gt = gt.gt;
Ileft = im2double(Ileft);
Iright = im2double(Iright);

%% Compute 
Jleft = getNeighborhoods(Ileft,neigh);
Jright = getNeighborhoods(Iright,neigh);

%% For each scan line compute the disparity
[h w d] = size(Ileft);
dispL = zeros([h w]);
dispR = zeros([h w]);
for i = 1:h,
	if(strcmpi(method,'ssd')),
		[dispL(i,:) dispR(i,:) dist] = ssd(Jleft(i,:,:),Jright(i,:,:));
	elseif(strcmpi(method,'ncc')),
		[dispL(i,:) dispR(i,:) dist] = ncc(Jleft(i,:,:),Jright(i,:,:));
	elseif(strcmpi(method,'dp')),
		[dispL(i,:) dispR(i,:) dist] = ssd(Jleft(i,:,:),Jright(i,:,:));
		dist = dist*(3*3*d)./(neigh*neigh*d);
		[dispL(i,:) dispR(i,:) dist] = dpMatch(dist,cocc);
	end
	fprintf([num2str(i) ', ']);
end
fprintf('\n');

%%
dispL(isnan(dispL)) = 0;
err = eval_disp(dispL,gt);

%% Visualize
%figure(1); subplot(1,2,1); imagesc(dispL,[-2 20]); subplot(1,2,2); imshow(Ileft);
%figure(2); subplot(1,2,1); imagesc(dispR,[-20 2]); subplot(1,2,2); imshow(Iright);
end
