%Rotation Matrix as defined by Rodrigues formula.
%Phi angle of rotation is in degrees
% Axis is the unit vector in axis of rotation
%flag  is set if cos(phi) =! 1/2(tr(R)-1)
%%
function [Y_rot] = rotate3D (Y, phi, axis)

[R Flag]= getRotMat(phi, axis);
for i=1:size(Y,1)
    Y_rot(i,:)=R*([Y(i,1) Y(i,2) Y(i,3)]');
end

end

%% Get rotation Matrix
function  [R,flag] = getRotMat(phi , axis)
    
%normalize axis
axis_norm= sqrt(axis(1)^2+axis(2)^2+axis(3)^2);
axis = axis./axis_norm;

%convert phi to radians
phi = phi*(pi/180);

S_hat = [ 0 -axis(3) axis(2); axis(3) 0 -axis(1);-axis(2) axis(1) 0];

R = eye(3) + sin(phi)*S_hat + (1-cos(phi))*(S_hat^2);

if ((cos (phi)- (0.5*(trace(R)-1)))> 1e-3)
    flag='true';
else
    flag='false';
end
    
end
