function [axis,phi ] = rotinv( R )
%ROTINV 
%Rotation Matrix as defined by Rodrigues formula.
%Phi angle of rotation is in Radians
%Axis is the unit vector in axis of rotation
%Animesh Garg - CS 280 HW1
%Spring 2012
 phi = acos ( 1/2*(trace(R)-1));
 
 if (phi <= 1e-10)
    axis = [ 0 0 0];
 else
    axis = (1/(2*sin(phi)))*[R(3,2)-R(2,3); R(1,3)-R(3,1);R(2,1)-R(1,2)];
    %R-R' = 2*sin(phi)*axis_hat 
    %axis_hat is skew-symmetric matrix corresponding to axis
 end
end

