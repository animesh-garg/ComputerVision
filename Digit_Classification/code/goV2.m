%% Addpath for liblinear

% FIXIT: 
% addpath(fullfile(pwd,'../liblinear/matlab/'));


%% Load training and test data
clear dt;

% FIXIT: 
% load(['../data/train_small.mat']);
TR = train;

% FIXIT: 
% load(['../data/test.mat']);
TST = test;
clear train;

%% Features Function Handles.

getfeatures{1} = @(x)rawpixelFeature(x);		% Raw pixel as features 
getfeatures{2} = @(x)spatialPyramid(x,[1 4 7]); % Spatial pyramid with cell size 1 4 7
getfeatures{3} = @(x)hog(x,'TAP');				% HOG on TAP
getfeatures{4} = @(x)hog(x,'OGF');				% HOG on Gaussian Filters
getfeatures{5} = @(x)hogNormalized(x,'TAP');	% Normalized HOG on TAP
getfeatures{6} = @(x)hogNormalized(x,'OGF');	% Normalizaed HOG on Gaussian Filters

load('svmC.mat');

%% Actual training and testing

for j = 1:6, % INFO: This selects the feature vector to use.
	test = TST;
	test.features = getfeatures{j}(test.images);
	for i = 1:7, % INFO : This selects which part of train to use for training.
		clear train;
		train = TR{i};

		train.features = getfeatures{j}(train.images);

		param.C = svmC(i,j);
		param.B = 10;
		model=train_linear_svm(train.features, train.labels, param);

		test.prediction = predict_linear_svm(test.features, model);

		[test.errorRate, test.wrongIND] = benchmark(test.prediction, test.labels);

		fprintf('Test set: error rate: %0.2f (%d/%d)\n', 100*test.errorRate,length(test.wrongIND),size(test.images,3));
		figure(2); imagesc(montage_images(test.images(:,:,test.wrongIND)));
		acc(i,j) = test.errorRate;
		acc
	end
end
