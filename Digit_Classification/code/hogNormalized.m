function features = hogNormalized(digits,filterType)
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
	feature = {};
	for c = [4 7],
		fLength = length(c:ceil(c/2):(size(o,1)+c-1))*length(c:ceil(c/2):(size(o,2)+c-1));
		f = zeros(nOri,fLength,size(o,3));
		for i = 1:nOri,
			tmp = ((edges(i) < o ) & (o <= edges(i+1)));
			f(i,:,:) = spatialPyramid(tmp,c);
		end
		f = f./repmat(sum(f,1),[size(f,1) 1 1]);
		feature{end+1,1} = reshape(f,[numel(f(:,:,1)) size(f,3)]);
	end
% 	keyboard;
	features = cell2mat(feature);
end
