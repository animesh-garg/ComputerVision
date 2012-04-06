%plot some curves after rotation
%Phi angle of rotation is in Radians
% Axis is the unit vector in axis of rotation
% Alpha the angle of line with x-axis (in radians)
%Animesh Garg - CS 280 HW1
%Spring 2012
function [] = rotate3d(phi, axis, alpha)
    X = transpose(linspace (0, 10));
    Y = tan(alpha)*X;
    
    [R Flag]= rot(phi, axis);
    Coord_prime = zeros (length(X),3);
    for i=1:length(X)
        Coord_prime(i,:)=R*([X(i) Y(i) 0]');
    end
    
    X_rot = Coord_prime (:,1);
    Y_rot = Coord_prime (:,2);
    
    figure();
    plot(X,Y,'-r')
    hold on
    plot (X_rot, Y_rot, '-g')
    hold off

end

