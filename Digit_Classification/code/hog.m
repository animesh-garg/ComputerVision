function features = hog(digits,filterType)
	if(~exist('filterType','var'))
		filterType = 'TAP';
	end
	nOri = 9;
	digits = double(digits);
	if(strcmp(filterType,'TAP'))
		hh = [-1 0 1];
		hv = [-1 0 1]';
	elseif(strcmp(filterType,'OGF'))
		[hh hv] = getGaussEdgeFilter(1,1,0);
		% 	hh = imfilter(fspecial('gauss',7,1),[-1 0 1]);
		% 	hv = imfilter(fspecial('gauss',7,1),[-1 0 1]');	
	end

	gh = imfilter(digits,hh);
	gv = imfilter(digits,hv);
	o = atan2(gv,gh);
	edges = linspace(-pi,pi,nOri+1);
	f = {};
	for i = 1:nOri,
		tmp = ((edges(i) < o ) & (o <= edges(i+1)));
		f{end+1,1} = spatialPyramid(tmp,[4 7]);
	end
	features = cell2mat(f);
end