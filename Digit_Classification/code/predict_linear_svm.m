function pred_labels=predict_linear_svm(features, model)
ypred=predict(ones(size(features,2),1),features, model, '', 'col');
pred_labels=ypred-1;
