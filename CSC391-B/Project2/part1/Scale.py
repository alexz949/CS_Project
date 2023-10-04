import numpy as np
import cv2

def sca_SIFT(path):
    
    img = cv2.imread(path)
    gray= cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
    #Do SIFT for original image
    sift = cv2.SIFT_create()
    kp = sift.detect(gray,None)
    out = cv2.drawKeypoints(gray,kp,img)

    #scale image to 0.75 of original and take an gaussian blur of 3 by 3
    percent = 75

    img2 = cv2.imread(path)
    width = int(img2.shape[1] * percent / 100)
    length = int(img2.shape[0] * percent / 100)
    dim = (width, length)
    img2 = cv2.resize(img2,dim,interpolation=cv2.INTER_AREA)
    #perform gaussian blur
    img2 = cv2.GaussianBlur(img2,(5,5),0)
    gray2  = cv2.cvtColor(img2,cv2.COLOR_BGR2GRAY)
    sift2 = cv2.SIFT_create()
    kp2 = sift2.detect(gray2,None)
    out2 = cv2.drawKeypoints(gray2,kp2,img2)



    cv2.imshow("sca_org SIFT",out)
    cv2.imshow("sca_75 SIFT",out2)

    cv2.waitKey(0)



def sca_FAST(path):
    print("hello world")
    img = cv2.imread(path)
    gray = cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)

    #Do FAST on original image with nonmax suppression
    fast = cv2.FastFeatureDetector_create()
    kp = fast.detect(gray,None)
    out = cv2.drawKeypoints(gray, kp, None, color=(255,0,0))


    #Scale to 0.75
    percent = 75

    img2 = cv2.imread(path)
    width = int(img2.shape[1] * percent / 100)
    length = int(img2.shape[0] * percent / 100)
    dim = (width, length)
    img2 = cv2.resize(img2,dim,interpolation=cv2.INTER_AREA)

    img2 = cv2.GaussianBlur(img2,(5,5),0)
    
    gray2  = cv2.cvtColor(img2,cv2.COLOR_BGR2GRAY)
    fast2 = cv2.FastFeatureDetector_create()
    kp2 = fast2.detect(gray2,None)

    out2 = cv2.drawKeypoints(gray2,kp2,None, color = (255,0,0))

    cv2.imshow("original FAST", out)
    cv2.imshow("scale FAST", out2)
    cv2.waitKey(0)




def sca_Harris(path):
    print("hello world")
    img = cv2.imread(path)
    gray = cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
    
    #harris corner detection
    gray = np.float32(gray)
    dst = cv2.cornerHarris(gray,2,3,0.04)
    dst = cv2.dilate(dst,None)
    img[dst>0.01*dst.max()]=[0,0,255]


    #do harris after skrink to 0.75
    percent = 75

    img2 = cv2.imread(path)
    width = int(img2.shape[1] * percent / 100)
    length = int(img2.shape[0] * percent / 100)
    dim = (width, length)
    img2 = cv2.resize(img2,dim,interpolation=cv2.INTER_AREA)
    img2 = cv2.GaussianBlur(img2, (5,5),0)
    #do harris
    gray2  = cv2.cvtColor(img2,cv2.COLOR_BGR2GRAY)
    gray2 = np.float32(gray2)

    dst2 = cv2.cornerHarris(gray2,2,3,0.04)
    dst2 = cv2.dilate(dst2,None)
    img2[dst2>0.01*dst2.max()] = [0,0,255]


    cv2.imshow("original Harris",img)
    cv2.imshow("scaled Harris", img2)

    cv2.waitKey(0)


def sca_ORB(path):
    print("hello world")
    img = cv2.imread(path)
    gray = cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
    
    #perform ORB on original image
    orb = cv2.ORB_create()
    kp = orb.detect(gray,None)
    kp, des = orb.compute(gray,kp)
    out = cv2.drawKeypoints(gray,kp,None,color = (255,0,0),flags=0)



    #perform ORB after scale to 0.75
    percent = 75

    img2 = cv2.imread(path)
    width = int(img2.shape[1] * percent / 100)
    length = int(img2.shape[0] * percent / 100)
    dim = (width, length)
    img2 = cv2.resize(img2,dim,interpolation=cv2.INTER_AREA)

    img2 = cv2.GaussianBlur(img2,(5,5),0)
    #do ORB
    gray2  = cv2.cvtColor(img2,cv2.COLOR_BGR2GRAY)
    orb2 = cv2.ORB_create()
    kp2 = orb2.detect(gray2,None)
    kp2, des2 = orb2.compute(gray2,kp2)
    out2 = cv2.drawKeypoints(gray2,kp2,None,color = (255,0,0), flags=0)

    


    cv2.imshow("original ORB",out)
    cv2.imshow("scaled ORB", out2)
    cv2.waitKey(0)



path = r'CSC391-B/Project2/part1/self-test.jpg'


sca_SIFT(path)
sca_FAST(path)
sca_Harris(path)
sca_ORB(path)


