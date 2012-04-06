function [model, param, errorRate] = train_with_validation(features, labels, params, IND)
%
errorRate = zeros(size(params));
for i = 1:length(params),
	model = train_linear_svm(features(:,IND{1}), labels(IND{1}),params(i));
	prediction = predict_linear_svm(features(:,IND{2}), model);
	errorRate(i) = benchmark(prediction, labels(IND{2}));
end

[gr ind] = min(errorRate);
param = params(ind);
model = train_linear_svm(features, labels, param);
end
