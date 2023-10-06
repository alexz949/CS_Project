import numpy as np
import cv2 
import time


img = cv2.imread("self-test.jpg")

gray= cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
#Do FAST for original image
fast1 = cv2.FastFeatureDetector_create()
brief = cv2.BRIEF_create()
kp1 = fast1.detect(gray,None)
_,des1 = brief.compute(gray,kp1)
out = cv2.drawKeypoints(gray,kp1,img)


cv2.imshow("test", out)
cv2.waitKey(0)
