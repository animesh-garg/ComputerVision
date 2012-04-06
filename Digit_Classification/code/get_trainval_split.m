function IND = get_trainval_split(N,seed, fraction)
	assert(sum(fraction) == 1, 'Fractions font sum to 1.');
	savedState = RandStream.getDefaultStream;
	RandStream.setDefaultStream(RandStream('mt19937ar','seed',seed));
	ind = randperm(N);
	
	done = 0;
	for i = 1:(length(fraction)-1)
		nThis = floor(fraction(i)*N);
		IND{i} = ind((done+1):(done+nThis));
		done = done+nThis;
	end
	IND{length(fraction)} = ind(done+1:end);
	defaultStream.State = savedState;
end