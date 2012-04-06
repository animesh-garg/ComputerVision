function [disparityL disparityR dist] = dpMatch(dist, cocc)
%Given a distance matrix dist, find the DP based solution to the matching
% dist is JrightxJleft distance matrix
	N = size(dist,1);
	cost = NaN(N+1,N+1);
	action = NaN(N+1,N+1);
	
	%Cost(i,j) is the cost of matching left(1...i-1) to right(1...j-1)
	%Action(i,j) is the action taken!
	% 1 for matched
	% 2 for left occluded
	% 3 for right occluded
	cost(1,1) = 0; action(1,1) = 0;
	
	%Left pixels are occluded
	for i = 2:N+1,
		cost(i,1) = cost(i-1,1)+cocc;
		action(i,1) = 2;
	end
	
	%Right pixels are occluded
	for j = 2:N+1,
		cost(1,j) = cost(1,j-1)+cocc;
		action(1,j) = 3;
	end
	
	%Table filling
	for i = 2:N+1,
		for j = 2:N+1,
			cCost(1) = cost(i-1,j-1) + dist(j-1,i-1);
			cCost(2) = cost(i-1,j) + cocc;
			cCost(3) = cost(i,j-1) + cocc;
			[cost(i,j) action(i,j)] = min(cCost);
		end
	end
	
	%Compute matching pixels for left and right scanlines
	j = N+1;
	i = N+1;
	disparityL = NaN(1,N);
	disparityR = NaN(1,N);
	while(i~= 1 || j~= 1), 
		switch(action(i,j))
			case 1,
				disparityL(1,i-1) = j-1;
				disparityR(1,j-1) = i-1;
				j = j-1;
				i = i-1;
			case 2,
				disparityL(1,i-1) = j-1;
				i = i-1;
			case 3,
				disparityR(1,j-1) = i-1;
				j = j-1;
		end
	end
	disparityL = (1:N) - disparityL;
	disparityR = (1:N) - disparityR;	
end