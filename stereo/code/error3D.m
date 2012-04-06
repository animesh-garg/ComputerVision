function [ err ] = error3D( X_est, X_act )
%Function to compute sum of squared error

if (size(X_est,1)==size(X_act,1))
    err=0;
    for i = 1: size(X_est,1)
        err = err + ((X_est(i,1)-X_act(i,1))^2+ (X_est(i,2)-X_act(i,2))^2);%sum of squared errors
    end
else
    disp('Size of arrays is not same. Error cannot be calculated')
end

end

