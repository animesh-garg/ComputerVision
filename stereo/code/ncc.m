function [disparityL disparityR d] = ncc(leftSL, rightSL)
% Function to compute disparity for left image scan line, also returns the
% distnace matrix.
% leftSL, rightSL is a 1xNx#features matrix
	N = size(leftSL,2);
	exL = repmat(leftSL,[N 1 1]);
	exR = repmat(permute(rightSL,[2 1 3]),[1 N 1]);
	d = -sum(exL.*exR,3)./sqrt(sum(exL.^2,3))./sqrt(sum(exR.^2,3));
	[gr disparityL] = min(d);
	disparityL = (1:N) - disparityL;
	[gr disparityR] = min(d');
	disparityR = (1:N) - disparityR;
end