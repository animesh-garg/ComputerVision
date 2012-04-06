function model=train_linear_svm(features, labels, param)
	C = 10;
	B = 10;
	if(exist('param','var'))
		C = param.C;
		B = param.B;
	end
	model=train(labels+1, features, sprintf('-s 3 -c %0.4f -B %0.4f',C,B), 'col');
end

