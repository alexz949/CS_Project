import numpy as np
import cv2 
import time

#timing function
def TicTocGenerator():
    # Generator that returns time differences
    ti = 0           # initial time
    tf = time.time() # final time
    while True:
        ti = tf
        tf = time.time()
        yield tf-ti # returns the time difference

TicToc = TicTocGenerator() # create an instance of the TicTocGen generator

# This will be the main function through which we define both tic() and toc()
def toc(tempBool=True):
    # Prints the time difference yielded by generator instance TicToc
    tempTimeInterval = next(TicToc)
    if tempBool:
        print( "Elapsed time: %f seconds.\n" %tempTimeInterval )

def tic():
    # Records a time in TicToc, marks the beginning of a time interval
    toc(False)

#Find keypoints using SIFT as detector and BRIEF as descriptor
def test_brief(path):
    img = cv2.imread(path)

    gray= cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
    #Do sift as a detector for original image
    
    sift1 = cv2.SIFT_create()
    brief = cv2.xfeatures2d.BriefDescriptorExtractor_create()
    kp1 = sift1.detect(gray,None)
    #find descriptor using BRIEF
    _,des1 = brief.compute(gray,kp1)
    


    

def test_sift(path):

    #Find keypoint using SIFT
    img = cv2.imread("self-test.jpg")

    gray= cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
    #Do SIFT for detector and descriptor
    sift = cv2.SIFT_create()
    kp1 = sift.detect(gray,None)
    _,dest = sift.compute(gray,kp1)

    
    

    

    

#test functions and timing
path = "self-test.jpg"
tic()
test_brief(path)
toc()
tic()
test_sift(path)
toc()


