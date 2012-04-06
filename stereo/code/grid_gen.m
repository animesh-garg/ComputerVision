function [ X ] = grid_gen( cube_size, discretization )
%size of cube in units
%discretization of cube - points per unit
x = linspace(0,cube_size, discretization*cube_size); 
y = linspace(0,cube_size, discretization*cube_size); 
z = linspace(0,cube_size, discretization*cube_size); 
X = zeros (((discretization*cube_size)^3),3);
n= 1;%counter for storage
for i = 1: size(x,2)
    for j = 1: size(y,2)
        for k = 1: size(z,2)
            X(n,1)= x(1,i);
            X(n,2)= y(1,j);
            X(n,3)= z(1,k);
            n= n+1;
        end
    end
end
end