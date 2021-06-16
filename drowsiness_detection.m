warning('off', 'all');
sprintf('starting code')

%open webcam
cam = webcam; 
preview(cam);

sprintf('Reading webcam video')

EyeDetect = vision.CascadeObjectDetector('EyePairBig');     %get Object Detector, for detecting pair of eyes

state=0;    %initial state of eyes assumed to be open
count=0;     %no. of frames partial/closed eyes were detected

countThreshold = 30;        %how long the person must be detected as drowsy = 60 frames
                            %fine-tune for increased accuracy
                        
for i = 1:1000      %capture 1000 frames from webcam
    
    if(count > countThreshold)
        
        load chirp.mat;         %play warning sound to awaken person
        sound(y, Fs);
        
        sprintf('Drowsiness detected')
        break;
    end
    
    I = snapshot(cam);      %cyapture webcam frame
    I = rgb2gray(I);        %convert frame to grayscale
    
    BB2=step(EyeDetect,I);  %detect coordinates of area around eyes (rectangular)
    
    [a,b] = size(BB2);
    
    if(a==0)                %if no eyes detected, capture next frame
        continue;
    end
    
    I=imcrop(I,[BB2(1,1) BB2(1,2) BB2(1,3) BB2(1,4)]);      %if eyes detected, crop out eyes section
    
    I=imresize(I,[ix iy]);      %resize cropped image for processing
    
    features = extractHOGFeatures(I);           %extract HOG features from eyes image
    
    prediction(i,1)=predict(mdl,features);      %predict state of eyes using trained model
    
    if (state==0)                   %if eyes were last detected open
        if (prediction(i,1))==2     %if currently eyes are closed
            count=count+1;
            state=1;                    %set state as drowsy
        
        elseif (prediction(i,1))==1     %if currently eyes are partially closed
            count=count+1;
            state=1;        %set state as drowsy
        end
    
    elseif (state==1)       %eyes were last detected partially closed or closed
        
        if(prediction(i,1))==1      %eyes are still partially closed
            count=count+1;
            state=1;
            
        elseif (prediction(i,1))==2         %eyes are still closed
            count=count+1;
            state=1;
        
        elseif (prediction(i,1))==0         %eyes are now open
            count=count/2; %
%             count=0;
            state=0;
        end      
    end
    
end

clear('cam');

if(count<30)
    sprintf('No drowsiness detected')
end