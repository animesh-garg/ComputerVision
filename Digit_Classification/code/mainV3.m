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

% getfeatures = @(x)rawpixelFeature(x);
getfeatures = @(x)hog(x);
seed = 1;

test = TST;
test.features = getfeatures(test.images);
train = TR{4};

train.features = getfeatures(train.images);
	
IND = get_trainval_split(size(train.images,3),seed,[0.5 0.5]);
[model, param] = train_with_validation(train.features, train.labels, params, IND);
[param.C param.B]

test.prediction = predict_linear_svm(test.features, model);
train.prediction = predict_linear_svm(train.features, model);

[train.errorRate, train.wrongIND] = benchmark(train.prediction, train.labels);
[test.errorRate, test.wrongIND] = benchmark(test.prediction, test.labels);

fprintf('Train set: error rate: %0.2f (%d/%d)\n', 100*train.errorRate,length(train.wrongIND),size(train.images,3));
% figure(1); imagesc(montage_images(train.images(:,:,train.wrongIND)));

fprintf('Test set: error rate: %0.2f (%d/%d)\n', 100*test.errorRate,length(test.wrongIND),size(test.images,3));
% figure(2); imagesc(montage_images(test.images(:,:,test.wrongIND)));


%% Draw rawpixel weights
for i = 1:10,
	digitW = reshape(model.w(i,1:end-1),[28 28]);
	figure(1); imagesc(digitW,[0 max(digitW(:))]); title(num2str(i-1));
	pause;
end

%% Draw hog vector
nOri = 8;
edges = linspace(-pi,pi,nOri+1);
for i = 1:10,
	digitW = model.w(i,1:end-1);
	digitW = digitW./max(digitW(:));
	nCells = length(digitW)/nOri;
	hw = sqrt(nCells);
	figure(1); clf; hold on;
	for j = 1:nOri,
		theta = (edges(j)+edges(j+1))/2;
		Y = repmat([hw:-1:1]',1,hw);
		X = repmat([1:1:hw],hw,1);
		oriW = digitW((j-1)*nCells+1:j*nCells);
% 		oriW = max(0,oriW);
		quiver(X(:),Y(:),oriW(:).*cos(theta),oriW(:).*sin(theta));
	end
	title(num2str(i-1));
	pause;
end

%%
% save(['../iResults/rawpixelFeature.mat'],'seed','dt');