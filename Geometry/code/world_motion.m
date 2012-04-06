function [ mot_t, mot_w ] = world_motion( P, C)
%WORLD_MOTION Summary of this function goes here
%   Detailed explanation goes here
    mot_t= 0; mot_w=0;
    tx=0;ty=0;tz=0;
    wx=0;wy=0;wz=0;
    
    switch C
        %Pure translation in z
        case 1
            tz = 5;
            mot_t = [tx ty tz]';
            mot_w = [wx wy wz]';
                          
        %Pure translation  along in XY plane
        case 2
           ty = 5; tx = -5;
           mot_t = [tx ty tz]';
           mot_w = [wx wy wz]';

        %Pure Rotation in Z  
        case 3
           wz = -5;
           mot_t = [tx ty tz]';
           mot_w = [wx wy wz]';
            
        %Rotation and translation Helix aligned along Z
        case 4
           tz = 5; wz = -5;
           mot_t = [tx ty tz]';
           mot_w = [wx wy wz]';
            
    end
    


end

