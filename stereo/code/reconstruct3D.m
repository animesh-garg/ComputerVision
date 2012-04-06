clear all
% close all

%% get model coordinates in a list of tuples
%X = getObjModel();
% X = [unidrnd(1000,500,1) unidrnd(1000,500,1) unidrnd(1000,500,1)];
X =dlmread('../data/bunny/pts1.txt');

figure('Position',[1,400,1400,400]);
subplot(1,4,1)
scatter(X(:,1),X(:,2),'filled')

%% Rotate the model by angle theta along unit vector of axis r
fName = 't100';
r = [1 2 1];
t = [0 0 -600];
theta = 90;%theta in degrees

%Rotate and translate
X_rot = rotate3D(X,theta,r);
X_o = t;
X_o = repmat(X_o, size(X_rot,1),1);
X_tran = X_rot - X_o; 

% Perspective projection using f=1
f=1;
PerspX = X_tran(:,1)./X_tran(:,3);
PerspY =  X_tran(:,2)./X_tran(:,3);
X_persp = [PerspX.*f PerspY.*f repmat(f, size(X_tran,1),1)];
X_im_2D = [X_persp(:,1) X_persp(:,2)]; %Actual Image after transformation

% visualize
subplot(1,3,1)
scatter (X_im_2D(:,1), X_im_2D(:,2),'.');
title(fName)

%% Pick 3 corresponding points

nm = unidrnd(size(X,1),1,3); %index of three points

%% Preprocessing of the point cloud.
am = X(nm(1),:);
bm = X(nm(2),:);
cm = X(nm(3),:);
Xpp = X-repmat(am,size(X,1),1);

%rotate so that bm and cm are in x-y plane
bm_cap = (bm-am)/norm(bm-am);
cm_cap = (cm-am)/norm(cm-am);
n_cap = cross(bm_cap, cm_cap);%normal vector to plane a-b-c
n_cap = n_cap./norm(n_cap);
n= [0 0 1]'; %normal to x-y plane.
phi= -acosd (dot(n_cap, n));% angle of rotation to bring bm-cm in x-y plane

%calculate axis
ax = cross(n,n_cap);
ax = ax./norm(ax);
Xpp = rotate3D(Xpp,phi,ax);

%% get Parameters for Huttenlocher-Ullman Estimation of the transformation using ONE corresponding triplet
least_sq = false;
P = getParam3D(Xpp,X_im_2D,nm,nm,least_sq);
X_est = transform3D(Xpp, P);

subplot(1,3,2)
scatter(X_est(:,1),X_est(:,2),'r.');
Err_woLeastSq = error3D(X_est, X_im_2D);
rms_woLeastSq = sqrt(Err_woLeastSq)/size(X,1);

title(['RMS_{CorrespPoint} ' num2str(rms_woLeastSq,'%e')]);

%% get Parameters for Huttenlocher-Ullman Estimation of the transformation using one set of Non-Corresponding Triplet
least_sq= false;
ni = unidrnd(size(X,1),1,3); %index of three points different from nm.
P_NC = getParam3D(Xpp,X_im_2D,nm,ni,least_sq);
X_est_NC = transform3D(Xpp, P_NC);

subplot(1,3,3)
scatter(X_est_NC(:,1),X_est_NC(:,2),'r.');
Err_NC= error3D(X_est_NC, X_im_2D);
rms_NC = sqrt(Err_NC)/size(X,1);
title(['RMS_{NonCorrespPoint} ' num2str(rms_NC,'%e')]);

% set(gcf,'PaperPositionMode','auto');
% saveImg(gcf,['3dr_bunny_' fName]);
