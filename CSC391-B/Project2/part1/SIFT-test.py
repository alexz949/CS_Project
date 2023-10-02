import numpy as np
import cv2 

#this is only the brightness test

img = cv2.imread('CSC391-B/Project2/part1/big-samu-copy.jpg')
gray= cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
sift = cv2.SIFT_create()
kp = sift.detect(gray,None)
img=cv2.drawKeypoints(gray,kp,img)







cv2.imshow("SIFT", img)





img = cv2.imread('CSC391-B/Project2/part1/big-samu-copy.jpg')
alpha = 1.5 # Contrast control
beta = 10 # Brightness control

# call convertScaleAbs function
img = cv2.convertScaleAbs(img, alpha=alpha, beta=beta)

gray= cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
sift = cv2.SIFT_create()
kp = sift.detect(gray,None)
img=cv2.drawKeypoints(gray,kp,img)





cv2.imshow("bright", img)


cv2.waitKey(0)





