function [gu,gv] = gaussGradFilter(IM, sigma_u, sigma_v, theta)
%[gu,gv] = gaussGradFilter( IM,sigma_u,sigma_v,theta )
%     input args: image, variance in direction 1 (u), variane in direction 2(u),
%     theta is orientation of the u-v frame w.r.t. to x-y frame measured anti-clockwise
%     theta is in degrees. 

[hu,hv] = getGaussEdgeFilter(sigma_u,sigma_v,theta);

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
