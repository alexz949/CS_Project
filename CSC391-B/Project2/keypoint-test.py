import numpy as np
import cv2



img = cv2.imread('Project2/big-samu-copy.jpg')
gray= cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
sift = cv2.SIFT_create()
kp = sift.detect(gray,None)
img=cv2.drawKeypoints(gray,kp,img)


surf = cv2.xfeatures2d.SURF_create(400)
kp = surf.detect(gray,None)
img2 = cv2.drawKeypoints(gray,kp,None,(255,0,0),4)



cv2.imshow("SURF",img2)
cv2.imshow("SIFT", img)




cv2.waitKey(0)