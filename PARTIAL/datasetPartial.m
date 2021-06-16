clc;
clear;

cam = webcam;
preview(cam);

%EyeDetect = vision.CascadeObjectDetector('EyePairBig');     %get Object Detector, for detecting pair of eyes

savepath = '/Users/shahrosekhaliq/Desktop/AI Project/PARTIAL';  %the folder
nametemplate = 'image_%04d.jpg';  %name pattern
i = 0;        %starting image number

count = 0;

for K = 1:300 %for taking 100 images
    if(count == 100)
        break
    end
    img = snapshot(cam);
    if(K<=4)
       continue
    end
    i = i+1;
    thisfile = sprintf(nametemplate, i);  %create filename
    fullname = fullfile(savepath, thisfile); %folder and all
    img = rgb2gray(img);
    
    BB2=step(EyeDetect,img);  %detect coordinates of area around eyes (rectangular)
    [a,b] = size(BB2);
    if(a==0)                %if no eyes detected, capture next frame
        continue;
    end
    img=imcrop(img,[BB2(1,1) BB2(1,2) BB2(1,3) BB2(1,4)]);      %if eyes detected, crop out eyes section
    
    img=imresize(img,[ix iy]);      %resize cropped image for processing
    imwrite(img,fullname); %write the image there as jpg
    count = count + 1;
end

clear;