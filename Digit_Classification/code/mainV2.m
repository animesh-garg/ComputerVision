%% Addpath for liblinear
addpath(fullfile(pwd,'../liblinear/matlab/'));


%% Load training and test data
clear dt;
load(['../data/train_small.mat']);
TR = train;
load(['../data/test.mat']);
TST = test;
clear train;
params = get_params;
%%
getfeatures = @(x)hog(x,'TAP');
seed = 1;

test = TST;
test.features = getfeatures(test.images);
for i = 1:5,
	clear train;
	train = TR{i};

	train.features = getfeatures(train.images);
	
	IND = get_trainval_split(size(train.images,3),seed,[0.5 0.5]);
	[model(i), param(i)] = train_with_validation(train.features, train.labels, params, IND);
	[param(i).C param(i).B]
	
	test.prediction = predict_linear_svm(test.features, model(i));
	train.prediction = predict_linear_svm(train.features, model(i));
	
	[train.errorRate, train.wrongIND] = benchmark(train.prediction, train.labels);
	[test.errorRate, test.wrongIND] = benchmark(test.prediction, test.labels);

	fprintf('Train set: error rate: %0.2f (%d/%d)\n', 100*train.errorRate,length(train.wrongIND),size(train.images,3));
	% figure(1); imagesc(montage_images(train.images(:,:,train.wrongIND)));

	fprintf('Test set: error rate: %0.2f (%d/%d)\n', 100*test.errorRate,length(test.wrongIND),size(test.images,3));
	% figure(2); imagesc(montage_images(test.images(:,:,test.wrongIND)));
	dt(i,:) = [train.errorRate test.errorRate param(i).C param(i).B];
end
%%
save(['../iResults/hog.mat'],'seed','dt');


%% Test gaussian filter edges


digits = double(digits);
[gx gy] = gaussGradFilter(digits,1,1,0);
figure(1); subplot(1,3,1); imagesc(digits); axis equal; axis off;
figure(1); subplot(1,3,2); imagesc(gx); axis equal; axis off;
figure(1); subplot(1,3,3); imagesc(gy); axis equal; axis off;

h = [-1 0 1];
sDigits = imfilter(digits,fspecial('gauss',1,1));
gh = imfilter(sDigits,h);
gv = imfilter(sDigits,h');
figure(2); subplot(1,3,1); imagesc(digits); axis equal; axis off;
figure(2); subplot(1,3,2); imagesc(gh); axis equal; axis off;
figure(2); subplot(1,3,3); imagesc(gx); axis equal; axis off;


