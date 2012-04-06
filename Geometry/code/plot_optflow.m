function [ ] = plot_optflow( C1, C2 )
%PLOT_OPTFLOW Summary of this function goes here
%   Detailed explanation goes here
    %parameter
    %f = 1

 
      
    [X, Y, Z] = scene(C1); % C is the case of the scene
    P = [X, Y, Z];
    [mot_t, mot_w]= world_motion(P,C2);
    
    if (Z ~= 0) 
        x = X./Z; y = Y./Z;
    else
        x = X; y= Y;
    end
    
    
    Opt_Flow = optflow( P, mot_t, mot_w );
    u = Opt_Flow(:,1);
    v = Opt_Flow(:,2);
    
    %plot3 (X,Y,Z);
    
    figure
    quiver(x,y,u,v)
    xlabel('X-Axis');
    ylabel('Y-Axis');
    %colormap hsv
    %hold off  

end

