function [train, test]=create_train_test_data
load mnist_all.mat
images=zeros(28,28,60000);
labels=zeros(60000,1);
cnt=0;
for k=0:9
    varname=sprintf('train%d',k);
    I=eval(varname);
    I=reshape(I, [size(I,1), 28, 28]);
    I=permute(I,[3 2 1]);
    images(:,:,cnt+1:cnt+size(I,3))=I;
    labels(cnt+1:cnt+size(I,3))=k;
    cnt=cnt+size(I,3);
end
train.images=uint8(images(:,:,1:cnt));
train.labels=labels(1:cnt);

images=zeros(28,28,60000);
labels=zeros(60000,1);
cnt=0;
for k=0:9
    varname=sprintf('test%d',k);
    I=eval(varname);
    I=reshape(I, [size(I,1), 28, 28]);
    I=permute(I,[3 2 1]);
    images(:,:,cnt+1:cnt+size(I,3))=I;
    labels(cnt+1:cnt+size(I,3))=k;
    cnt=cnt+size(I,3);
end

test.images=uint8(images(:,:,1:cnt));
test.labels=labels(1:cnt);



