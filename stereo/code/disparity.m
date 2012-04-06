%% Load Images
imgName = 'tsukuba';
Ileft = imread(['../data/' imgName '/left.png']);
Iright = imread(['../data/' imgName '/right.png']);
gt = load(['../data/' imgName '/gt.mat']);
gt = gt.gt;
Ileft = im2double(Ileft);
Iright = im2double(Iright);

%% Compute features
neigh = 3;
Jleft = getNeighborhoods(Ileft,neigh);
Jright = getNeighborhoods(Iright,neigh);
%% For each scan line compute the disparity
[h w d] = size(Ileft);
dispL = zeros([h w]);
dispR = zeros([h w]);
for i = 1:h,

	[dispL(i,:) dispR(i,:) dist] = ssd(Jleft(i,:,:),Jright(i,:,:));
	[dispL(i,:) dispR(i,:) dist] = dpMatch(dist,0.05);
	i
end

%%
eval_disp(dispL,gt)

%% Visualize
figure(1); subplot(1,2,1); imagesc(dispL,[0 20]); subplot(1,2,2); imshow(Ileft);
figure(2); subplot(1,2,1); imagesc(dispR,[-20 0]); subplot(1,2,2); imshow(Iright);