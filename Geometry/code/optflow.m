function [ Opt_Flow ] = optflow( P, mot_t, mot_w )
%OPTFLOW Summary of this function goes here
%   Detailed explanation goes here
 
    %w = [wx wy wz]';
    %t = [tx ty tz]';
    X = P(:, 1); Y = P(:,2); Z= P(:,3); 
    
    %use f= 1
    if (Z ~= 0) 
        x = X./Z; y = Y./Z;
    else
        x = X; y= Y;
    end
    
    Opt_Flow = zeros(size(X,1),2);
    for i = 1: size(X,1)
        A = [-1 0 x(i);0 -1 y(i)];
        A = A/Z(i);
        B = [x(i)*y(i) -(1+x(i)^2) y(i);(1+y(i)^2) -x(i)*y(i) -x(i)];
        Opt_Flow(i,:)= transpose(A*mot_t + B*mot_w);
        %Opt_Flow(i,:)= [OF(1,1) OF(2,1)];
    end
    
end

