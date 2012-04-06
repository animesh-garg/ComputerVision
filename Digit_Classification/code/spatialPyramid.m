function features = spatialPyramid(digits,C)
	if(~exist('C','var'))
		C = [1 4 7];
	end
	digits = double(digits);
% 	features = zeros(:,size(digits,3));
	f = {};
	for c = C,
		h = ones(c);
		sumDigits = imfilter(digits,h,'full');
		tmp = sumDigits(c:ceil(c/2):end,c:ceil(c/2):end,:);
		f{end+1,1} = reshape(tmp,[size(tmp,1)*size(tmp,2) size(tmp,3)]);
		size(f{end});
	end
	features = cell2mat(f);
end