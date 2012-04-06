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

getfeatures{1} = @(x)rawpixelFeature(x);
getfeatures{2} = @(x)spatialPyramid(x,[1 4 7]);
getfeatures{3} = @(x)hog(x,'TAP');
getfeatures{4} = @(x)hog(x,'OGF');
getfeatures{5} = @(x)hogNormalized(x,'TAP');
getfeatures{6} = @(x)hogNormalized(x,'OGF');

fileName{1} = 'rawPixel';
fileName{2} = 'spRawPixel';
fileName{3} = 'hogTAP';
fileName{4} = 'hogOGF';
fileName{5} = 'nHogTAP';
fileName{6} = 'nHogOGF';

%%

for j = 1:6,
seed = 1;

test = TST;
test.features = getfeatures{j}(test.images);
clear dt wrongIND;
	for i = 1:7,
		clear train;
		train = TR{i};

		train.features = getfeatures{j}(train.images);

		IND = get_trainval_split(size(train.images,3),seed,[0.5 0.5]);
		[model(i), param(i), errorrate] = train_with_validation(train.features, train.labels, params, IND);
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
		wrongIND{i} = test.wrongIND;
	end
	%save(['../iResults/' fileName{j} '.mat'],'seed','dt','wrongIND');
end
%%
acc = [];
for j = 1:6,
	dt = load(['../iResults/' fileName{j} '.mat'],'seed','dt');
	acc = [acc, dt.dt(:,3)]; 
end
acc
