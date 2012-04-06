outFileName = 'allV4'
imgName = {'tsukuba','cones','teddy'};
neigh = 3:4:15;
methodName = {'ssd','ncc','dp','dp','dp'};
cocc = [0 0 0.05 0.1 0.5];
for imgNum = 1:length(imgName),
	for neighNum = 1:length(neigh),
		for methodNum = 1:length(methodName),
			if(methodNum >= 4 && neighNum > 1)
				err = NaN;
				out(imgNum,neighNum,methodNum).err = err;
				
			else
				[dispL dispR err] = goDisparity(imgName{imgNum}, neigh(neighNum), methodName{methodNum}, cocc(methodNum));
				out(imgNum,neighNum,methodNum).dispL = dispL;
				out(imgNum,neighNum,methodNum).dispR = dispR;
				out(imgNum,neighNum,methodNum).err = err;	
			end
			err
			save(['../results/' outFileName '.mat'],'out','imgName','neigh','methodName','cocc');
		end
	end
end
	
