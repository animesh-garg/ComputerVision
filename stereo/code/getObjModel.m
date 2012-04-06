% Generate an Object Model with floating spheres in a cube
function [Y] = getObjModel()
%Parameters
L=1;  % Length of Bounding cube
r = L/10;
NumSphr = 10;%Number of spheres in cube


%plot cube frame
%figure()
%plot_cube_frame (L);
%grid on

u_lim = 0;
discretization= 25; %discretization of points per unit
X=grid_gen(L,discretization); %Divide the cube in set of points

n=1;%counter for number of spheres to plot.
while (n<NumSphr+1)
    overlap=0;
    xi(n)= random('unif',0+r,L-r);
    yi(n)= random('unif',0+r,L-r);
    zi(n)= random('unif',0+r,L-r);
    [x,y,z] = ellipsoid(xi(n),yi(n),zi(n),r,r,r,20);
    if (n>1)
       for i=1:1:n-1
           if sqrt((xi(n)-xi(i))^2+(yi(n)-yi(i))^2+(zi(n)-zi(i))^2) < 2*r
                overlap=1; 
                break
           end
           u_lim = u_lim+1;
       end
    end
    if (overlap ==0)
        n= n+1;
        %ssurf(x,y,z)
    end
    if (u_lim > (50*NumSphr))
        break
    end
end

%Y has the points which lie in the sphere in discrete set
k=1;
for i=1:size(X,1)
    for j=1:n-1
        if ((((-xi(1,j)+X(i,1))/(r))^2)+(((-yi(1,j)+X(i,2))/(r))^2)+(((-zi(1,j)+X(i,3))/(r))^2))<1
                Y(k,:)=X(i,:);
                k=k+1;
        end
    end
end

%figure(2)
%plot_cube_frame (L);
%hold on
%scatter3(Y(:,1),Y(:,2),Y(:,3));

end




