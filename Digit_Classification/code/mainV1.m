%% The main file

%% Addpath for liblinear
addpath(fullfile(pwd,'../liblinear/matlab/'));


%% Load training and test data
load(['../data/train_small.mat']);
load(['../data/test.mat']);
tr = train;


train = tr{4};
%% Training, prediction and error visualization
train.features = rawpixelFeature(train.images);
test.features = rawpixelFeature(test.images);

model = train_linear_svm(train.features, train.labels);

train.prediction = predict_linear_svm(train.features, model);
[train.errorRate, train.wrongIND] = benchmark(train.prediction,train.labels);

test.prediction = predict_linear_svm(test.features, model);
[test.errorRate, test.wrongIND] = benchmark(test.prediction,test.labels);

fprintf('Train set: error rate: %0.2f (%d/%d)\n', 100*train.errorRate,length(train.wrongIND),size(train.images,3));
% figure(1); imagesc(montage_images(train.images(:,:,train.wrongIND)));

fprintf('Test set: error rate: %0.2f (%d/%d)\n', 100*test.errorRate,length(test.wrongIND),size(test.images,3));
figure(2); imagesc(montage_images(test.images(:,:,test.wrongIND)));