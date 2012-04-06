function [ gu,gv ] = gauss_grad_filter( IM,sigma_u,sigma_v,theta )
%GAUSS_GRAD_FILTER Summary of this function goes here
    %input args: image, variance in direction 1 (u), variane in direction 2(u),
    % theta is orientation of the u-v frame w.r.t. to x-y frame measured anti-clockwise
    %theta is in degrees. 
eps=1e-2;

halfsize_u=ceil(sigma_u*sqrt(-2*log(sqrt(2*pi)*sigma_u*eps)));
size_u=2*halfsize_u+1;
halfsize_v=ceil(sigma_v*sqrt(-2*log(sqrt(2*pi)*sigma_v*eps)));
size_v=2*halfsize_v+1;

theta = theta * pi/180;
rot = [cos(theta) -sin(theta); sin(theta) cos(theta)];

for i = 1: size_u
    for j = 1:size_v
        
        X =[i-halfsize_u-1; j-halfsize_v-1]; % X = [x; y]
        U = rot*X;% U = [u; v]
        hu(i,j)=gauss(U(1),sigma_u)*dgauss(U(2),sigma_v);
        hv(i,j)=dgauss(U(1),sigma_u)*gauss(U(2),sigma_v);
    end
end

hu=hu/sqrt(sum(sum(abs(hu).*abs(hu))));
hv=hv/sqrt(sum(sum(abs(hv).*abs(hv))));

%2-D filtering
gu=imfilter(double(IM),hu,'replicate','conv');
gv=imfilter(double(IM),hv,'replicate','conv');

end

%Gaussian
function y = gauss(x,sigma)
    y = exp(-x^2/(2*sigma^2)) / (sigma*sqrt(2*pi));
end

%first order derivative of Gaussian
function y = dgauss(x,sigma)
    y = -x * gauss(x,sigma) / sigma^2;
end
