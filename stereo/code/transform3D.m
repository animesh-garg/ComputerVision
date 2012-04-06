function [ X_est2d ] = transform3D (X, P )
%Calculate the parameters c1 and c2 and then sR.
% use x' = sRx + b for calculating image of model x = (xm,ym,0)
% now orthographic projection of x' to get estimated image.
l_11= P(1,1);
l_12= P(1,2);
l_21= P(2,1);
l_22=P(2,2);
b = P(:,3);

w = (l_12)^2 +(l_22)^2 - (l_11)^2 - (l_21)^2 ;
q= l_11*l_12 + l_21*l_22;
c1 = sqrt(0.5*(w+sqrt((w^2)+4*(q^2))));
c2 = -q/c1;
c1 = -c1; c2=-c2;
s= sqrt((l_11^2)+(l_21^2)+(c1^2));

sR = [l_11 l_12 ((c2*l_21)-(c1*l_22))/s;
      l_21 l_22 ((c1*l_12)-(c2*l_11))/s;
      c1   c2   ((l_11*l_22)-(l_21*l_12))/s];
  
 % catenate a row zeros to X 
 X_est = zeros(size(X,1), 3);
 for i = 1: size(X,1)
     X_est(i,:) = transpose( sR*(X(i,:)') - b); 
 end
 X_est2d = [X_est(:,1) X_est(:,2)];%output is a list of 2d coordinates
 
end

