function [ X,Y,Z ] = scene( C )
%SCENE 
%   Coordinate mesh of the scene
    X=0;Y=0;Z=0;
    switch C
        %Wall in front
        case 1
            [X,Y] =  meshgrid(-5:.2:5, -5:.5:5);
            Z = 10+(X.*exp(-X.^2 - Y.^2));
            surf(X,Y,Z)
            X = reshape(X,[],1);
            Y = reshape(Y,[],1);
            Z = reshape(Z,[],1);
            
        %Hour-glass Centered at (0,0,5)
        case 2
            t = 0:pi/10:2*pi;
            [X,Z,Y] = cylinder(6+3*cos(t));
            Z = 5*(Z + 5);
            Y = 10*Y;
            surf(X,Y,Z)
            axis square
            daspect([1 1 1])
            X = reshape(X,[],1);
            Y = reshape(Y,[],1);
            Z = reshape(Z,[],1);
            Z = (Z + 5);

       %Sphere centered at (0,0,5)    
       case 3
          [X,Y,Z] = sphere;
          Z = (Z + 5);
          surf(X,Y,Z)
          axis square
          daspect([1 1 1])
          X = reshape(X,[],1);
          Y = reshape(Y,[],1);
          Z = reshape(Z,[],1);
          
    end 
end

