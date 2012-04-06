function params = get_params()
	C = 10.^[-2:2:2];	
	B = 10.^[1];
	params = [];
	for i = 1:length(C),
		for j = 1:length(B),
			params(end+1).C = C(i);
			params(end).B = B(j);
		end
	end
		
end
