import numpy as np
import cv2 

img = cv2.imread('CSC391-B/Project2/part1/big-samu-copy.jpg')
# Initiate ORB detector
orb = cv2.ORB_create()
# find the keypoints with ORB
img= cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
kp = orb.detect(img,None)
# compute the descriptors with ORB
kp, des = orb.compute(img, kp)
# draw only keypoints location,not size and orientation
img2 = cv2.drawKeypoints(img, kp, None, color=(0,255,0), flags=0)




cv2.imshow('ORB',img2)


img = cv2.imread('CSC391-B/Project2/part1/big-samu-copy.jpg')
alpha = 1.5 # Contrast control
beta = 10 # Brightness control
gray= cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
# call convertScaleAbs function
img = cv2.convertScaleAbs(gray, alpha=alpha, beta=beta)

orb = cv2.ORB_create()
# find the keypoints with ORB
kp = orb.detect(img,None)
# compute the descriptors with ORB
kp, des = orb.compute(img, kp)
# draw only keypoints location,not size and orientation
img2 = cv2.drawKeypoints(img, kp, None, color=(0,255,0), flags=0)


cv2.imshow('test', img2)

cv2.waitKey(0)








