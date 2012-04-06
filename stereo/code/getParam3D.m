function [ P ] = getParam3D(Xm, Xi, nm, ni, least_sq )
%calculate parameters for estimation of image from model using 
%Huttenlocher-Ullman(1990) appraoch
% If least_sq is true then we use multiple triples for estimation of
% parameters
%Xm is 3D object coordinates, Xi are 2D image coordinates.

if (least_sq ==false)
    
    %choose 3 corresponding points in object and image
    am = Xm(nm(1),:)';bm = Xm(nm(2),:)';cm = Xm(nm(3),:)';
    ai = Xi(ni(1),:)';bi = Xi(ni(2),:)';ci = Xi(ni(3),:)';
    Am = [am bm cm]; Ai= [ai bi ci];
    
    %get parameters
    P = estimateParam(Ai, Am);
    
    
elseif(leastsq == true)
    %choose 3 corresponding points many times to get least squares estimate
    disp('WRITE CODE HERE')
    
else
    disp('least_sq  can either be true or false')
end

end

function [P] = estimateParam (Ai,Am)

ai = Ai(:,1); bi= Ai(:,2);ci=Ai(:,3);
am = Am(:,1); bm= Am(:,2);cm=Am(:,3);

%translate image origin to ai.
Ai= [zeros(2,1) bi-ai ci-ai];
b= -ai;
    
%Reassign ai,bi,ci, am,bm,cm after transformations to calculate L
ai = Ai(:,1); bi= Ai(:,2);ci=Ai(:,3);

A = [ bm(1,1) bm(2,1); cm(1,1) cm(2,1)];
B = [bi(1, 1); ci(1,1)];
C = [bi(2,1); ci(2,1)];
l1 = linsolve(A,B);
l2 = linsolve(A,C);

L = [l1(1,1) l1(2,1); l2(1,1) l2(2,1);0 0];

P = [L [b;0]];
end
