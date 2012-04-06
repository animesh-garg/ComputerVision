fileName{1} = 'rawPixel';
fileName{2} = 'spRawPixel';
fileName{3} = 'hogTAP';
fileName{4} = 'hogOGF';
fileName{5} = 'nHogTAP';
fileName{6} = 'nHogOGF';

clear dt;
load(['../data/train_small.mat']);
TR = train;
load(['../data/test.mat']);
TST = test;
clear train;

acc = [];
figure(1); clf; hold on;
colstr = 'rbgymk';

for i = 1:7
	s(i) = size(TR{i}.images,3);
	trainSize{i} = num2str(s(i));
end
for j = 1:6,
    dt{j} = load(['../iResults/' fileName{j} '.mat']);
    acc = [acc, dt{j}.dt(:,2)];

	plot(log10(s),acc(:,j),[colstr(j) '.-'],'LineWidth',2);
end
legend(fileName);


I = montage_images(TST.images(:,:,dt{6}.wrongIND{7}));
figure(2); imagesc(I); 
