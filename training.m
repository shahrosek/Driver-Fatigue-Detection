clc;
clear;

%dimensions of eyes images
ix=50;
iy=150;

feature_matrix=zeros(300,3060); %create matrix for extracted features
label_matrix=zeros(300,1); %create a matrix to hold labels for different classes

%assign labels 0,1,2
label_matrix(1:100,1)=0;
label_matrix(101:200,1)=1;
label_matrix(201:300,1)=2;

%assign directories for training the model
dir_open = 'OPEN';
dir_close = 'CLOSED';
dir_partial = 'PARTIAL';

%
img_open = dir(fullfile(dir_open,'*.jpg'));
img_close = dir(fullfile(dir_close, '*.jpg'));
img_partial = dir(fullfile(dir_partial, '*.jpg'));

%train on images of completely open pair of eyes
for i=1:numel(img_open):1
    
    I = fullfile(dir_open,img_open(i).name);
    I=imresize(I,[ix iy]); %resize file to pre-defined dimensions
    features = extractHOGFeatures(I); %extract HOG features from eye image
    feature_matrix(i,:)=features(1,:); %save extracted features into features matrix
    
end

%train on images of partially open pair of eyes
for i=1:numel(img_close):1
    
    I = fullfile(dir_close,img_close(i).name);
    I=imresize(I,[ix iy]);
    features = extractHOGFeatures(I);
    feature_matrix(i+100,:)=features(1,:);
    
end

%train on images of closed pair of eyes
for i=1:numel(img_partial):1
    
    I = fullfile(dir_partial,img_partial(i).name);
    I=imresize(I,[ix iy]);
    features = extractHOGFeatures(I);
    feature_matrix(i+200,:)=features(1,:);
    
end

%save trained classifier model, assign class labels to features
mdl = fitcknn(feature_matrix,label_matrix);