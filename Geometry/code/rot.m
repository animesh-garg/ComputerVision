%Rotation Matrix as defined by Rodrigues formula.
%Phi angle of rotation is in Radians
% Axis is the unit vector in axis of rotation
%flag  is set if cos(phi) =! 1/2(tr(R)-1)
%Animesh Garg - CS 280 HW1
%Spring 2012
function  [R,flag] = rot(phi , axis)

    S_hat = [ 0 -axis(3) axis(2); axis(3) 0 -axis(1);-axis(2) axis(1) 0];
    
    R = eye(3) + sin(phi)*S_hat + (1-cos(phi))*(S_hat^2);
    
    if ((cos (phi)- (0.5*(trace(R)-1)))> 1e-3)
        flag='true';
    else
        flag='false';
    end
    
end
