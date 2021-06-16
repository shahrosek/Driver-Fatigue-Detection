How to run:
1. First run training.m:
 It uses folders: OPEN, CLOSED, PARTIAL as the dataset. Make sure the these folders are in the same directory as the code.
2. Then run drowsiness_detection.m without clearing the workspace.
(If you have more than one webcam attached to your computer, then select own webcam model using "webcamlist" command in Matlab)
3. Webcam preview will open. Code will detect when user is becoming sleepy, and play built-in chirping sound to alert driver.
4. If you want a dataset for one's own images, you can use datasetOpen.m, datasetClose.m and datasetPartial.m for having a dataset of each type (Open, close and partial) to be provided for the training set.
5. Dependency: I have used MATLAB as the development environment to achieve this task. The system running this code must have MATLAB installed.
6. Training Set:
Includes 3 types of classes which are 100 images of normally open eyes. 100 images of partially closed eyes. 100 images of fully closed eyes.
7. Test Case:
I have used “extractHOGFeatures()”, to detect the current state, of the test object i.e. pair of eyes, against the trained set. The camera would take the picture of the whole face, but the algorithm would segment the eyes from it for further evaluation. The major function to detect the eyes, i.e. the segmentation of the eyes from the whole face, would be done by “vision.CascadeObjectDetector()”. If the user is classified, as drowsy based on our program, then the alarm sound form the laptop would intimate the result to wake the user.
8. Vision.CascadeObjectDetector:
This function uses the Viola-Jones Algorithm to detect peoples face, mouth eyes, nose etc. The pair of eyes is detected using this function and used as a test case.
9. extractHOGFeatures:
I have used this functions as (features = extractHOGFeatures(img)) which would return extracted Histogram of Gradient features from a grayscale input image, img. The features are returned in a 1-by-N vector, where N is the HOG feature length. The returned features encode local shape information from regions within an image. I have used this information for classification.
