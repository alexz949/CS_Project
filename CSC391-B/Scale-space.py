import cv2
import numpy as np
from matplotlib import pyplot as plt

img = cv2.imread('big-samu.jpg')
gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
si = [1,2,4,8,16,32,64]
percent = 100
for k in si:
    gray = cv2.GaussianBlur(gray,(2*k+1,2*k+1),k)
    

    
    width = int(gray.shape[1] * percent / 100)
    length = int(gray.shape[0] * percent / 100)
    dim = (width, length)
    gray = cv2.resize(gray,dim,interpolation=cv2.INTER_AREA)
    percent = percent / 2
    cv2.imshow("cool",gray)
    cv2.waitKey(0)

img = cv2.imread('big-samu.jpg')
gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

kernel = np.array([[0,1,0],[1,-4,1],[0,1,0]])
gray = cv2.filter2D(gray,0,kernel)
cv2.imshow("cool",gray)
cv2.waitKey(0)
