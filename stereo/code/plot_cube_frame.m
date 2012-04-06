function [ ] = plot_cube_frame( cube_size )
%PLOT_CUBE_FRAME Summary of this function goes here
%   Detailed explanation goes here
v1 = linspace(0,cube_size); v2 = zeros(size(v1)); v3 = cube_size*ones(size(v1));
e1 = [v1', v2', v2']; e2 = [v2', v1', v2']; e3 = [v1', v3', v2'];
e4 = [v3', v1', v2']; e5 = [v1', v2', v3']; e6 = [v2', v1', v3'];
e7 = [v1', v3', v3']; e8 = [v3', v1', v3']; e9 = [v2', v2', v1'];
e10= [v2', v3', v1']; e11= [v3', v2', v1']; e12= [v3', v3', v1'];
edges = {e1, e2, e3, e4, e5, e6, e7, e8, e9, e10, e11, e12};
for i = 1:12
    vec = edges{i};
    figure(1)
    subplot(1,2,1), hold on;
    plot3(vec(:,1), vec(:,2), vec(:,3), 'MarkerFacecolor','red');
    view([0.95 1.1 1.2]);
end

end

