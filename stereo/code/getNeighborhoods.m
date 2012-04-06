function J = getNeighborhoods(I,n)
% Takes in as input a single channel image and returns a I(:,:,n*n) matrix
% with vectorized neighborhoods.
[h w d] = size(I);
J = zeros([h w n*n*d]);
In = padarray(I,[floor(n/2) floor(n/2) 0],'replicate');
k = 1;
for i = 1:n
	for j = 1:n
		J(:,:,((k-1)*d+1):(k*d)) = In(i:(i+h-1),j:(j+w-1),:);
		k = k+1;
	end
end

end