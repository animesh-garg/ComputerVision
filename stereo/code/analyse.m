outFileName = 'allV4'
imgName = {'tsukuba','cones','teddy'};
neigh = 3:4:15;
methodName = {'ssd','ncc','dp','dp','dp'};
cocc = [0 0 0.05 0.1 0.5];
load(['../results/' outFileName '.mat']);

for i = 3:5,
	methodName{i} = [methodName{i} ' - ' num2str(cocc(i))];
end

%% Compairing different algorithms on same window size
figure(1); clf; 
for imgNum = 1:length(imgName),
	subplot(2,2,imgNum); title(['Image ' imgName{imgNum}]); hold on;
	err = [];
	for methodNum = 1:length(methodName),
		for neighNum = 1:length(neigh),
			err(neighNum,methodNum) = out(imgNum,neighNum,methodNum).err;
		end
	end
	plot(neigh',err,'.-');
% 	set(gca,'XTickLabel',num2str(neigh'));
	xlim([min(neigh) max(neigh)]);
	ylim([0 1]); ylabel('error');
	xlabel('neigh');
	legend(methodName);
	lOut = genTable(err,cellstr(num2str(neigh')),methodName,...
		[imgName{imgNum} ' - Variation of different algorithms with neighbor hood size.'],@(x)num2str(100*x,'%0.2f'))
end
% saveImg(gcf,'nsizeV4');

%%
% Effect of occlusion cost for each window size
figure(2); clf; 
for imgNum = 1:length(imgName),
	subplot(2,2,imgNum); title(['Image ' imgName{imgNum}]); hold on;
	err = [];
	for neighNum = 1:length(neigh),
		for methodNum = 3:length(methodName),
			err(methodNum-2,neighNum) = out(imgNum,neighNum,methodNum).err;
		end
	end
	
	plot(cocc(3:5)',err,'.-');
	legend(num2str(neigh'));
% 	set(gca,'XTickLabel',num2str(neigh'));
% 	xlim([min(neigh) max(neigh)]);
	ylim([0 1]); ylabel('error');
	xlim([0 0.5]);
	xlabel('cocc');
	lOut = genTable(err,cellstr(num2str(cocc(3:5)')),cellstr(num2str(neigh'))',...
		[imgName{imgNum} ' - Variation of DP method with cost occ and neighborhood size.'],...
		@(x)num2str(100*x,'%0.2f'))
end
% saveImg(gcf,'coccV4');
lOut = genTable(err,cellstr(num2str(cocc(3:5)')),cellstr(num2str(neigh'))',...
	'Variation of DP method with cost occ and neighborhood size.',@(x)num2str(100*x,'%0.2f'))


%% Visualize resulting disparities.
figure(3); clf; 
for imgNum = 1:length(imgName),
	
	Ileft = imread(['../data/' imgName{imgNum} '/left.png']);
	Iright = imread(['../data/' imgName{imgNum} '/right.png']);
	gt = load(['../data/' imgName{imgNum} '/gt.mat']);
	subplot(2,3,1); imagesc(Ileft); axis off;
	subplot(2,3,2); imagesc(gt.gt); axis off;
	subplot(2,3,3); imagesc(Iright); axis off;
	
	% For SSD/NCC variation with neighbor hood size.
	for methodNum = 1:2,
		for neighNum = 1:3,%length(neigh),
			figure(gcf);
			o = out(imgNum,neighNum,methodNum);
			subplot(2,3,3+neighNum); imagesc(o.dispL,[min(gt.gt(:)) max(gt.gt(:))]); axis off;
			title([imgName{imgNum} ', ' methodName{methodNum} ', ' num2str(neigh(neighNum)) ' - ' num2str(o.err)]);
		end
		saveImg(gcf,['method_' num2str(imgNum) '_'  num2str(methodNum) '_V4']);
		pause;
	end
	
	% For DP, plot with cocc variation with the same neighborhood of 3
	neighNum = 1;
	for methodNum = 3:5,
		figure(gcf);
		o = out(imgNum,neighNum,methodNum);
		subplot(2,3,methodNum+1); imagesc(o.dispL,[min(gt.gt(:)) max(gt.gt(:))]); axis off;
		title([imgName{imgNum} ', ' methodName{methodNum} ', ' num2str(neigh(neighNum)) ', ' num2str(cocc(methodNum)) ' - ' num2str(o.err)]);
	end
	saveImg(gcf,['method_' num2str(imgNum) '_3'  '_V4']);
	pause;
	
	% Compare the 3 algorithms for some particular neighborhood choice
	neighNum = 1;
	for methodNum = 1:3,
		figure(gcf);
		o = out(imgNum,neighNum,methodNum);
		subplot(2,3,3+methodNum); imagesc(o.dispL,[min(gt.gt(:)) max(gt.gt(:))]); axis off;
		title([imgName{imgNum} ', ' methodName{methodNum} ', ' num2str(neigh(neighNum)) ', ' num2str(cocc(methodNum)) ' - ' num2str(o.err)]);
	end
	saveImg(gcf,['compareAll_' num2str(imgNum) '_V4']);
	pause;
end
	