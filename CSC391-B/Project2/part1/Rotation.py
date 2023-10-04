import numpy as np
import cv2 

#This is for rotation part

def rot_SIFT(path):
    
    #convert to gray scale
    img = cv2.imread(path)
    gray= cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
    #Do SIFT for original image
    sift = cv2.SIFT_create()
    kp = sift.detect(gray,None)
    out = cv2.drawKeypoints(gray,kp,img)

    #rotate 90 degree counterclockwise 
    #img2 = cv2.rotate(img,cv2.ROTATE_180)
    gray2 = cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
    height, width = gray2.shape[:2]
    center = (width/2, height/2)
    rotate_matrix = cv2.getRotationMatrix2D(center=center, angle=45, scale=1)
    gray2 = cv2.warpAffine(src=gray2, M=rotate_matrix, dsize=(width, height))

    #gray2 = cv2.cvtColor(img2,cv2.COLOR_BGR2GRAY)

    sift2 = cv2.SIFT_create()
    kp2 = sift2.detect(gray2,None)
    out2 = cv2.drawKeypoints(gray2,kp2,None)

    cv2.imshow("origin SIFT",out)
    cv2.imshow("rotate SIFT", out2)
    cv2.waitKey(0)



def rot_FAST(path):
    #convert to gray scale
    img = cv2.imread(path)
    gray = cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)

    #Do FAST on original image with nonmax suppression
    fast = cv2.FastFeatureDetector_create()
    kp = fast.detect(gray,None)
    out = cv2.drawKeypoints(gray, kp, None, color=(255,0,0))
    


    #rotate image and do FAST again
    img2 = cv2.rotate(img,cv2.ROTATE_90_CLOCKWISE)
    gray2 = cv2.cvtColor(img2,cv2.COLOR_BGR2GRAY)
    

    fast2 = cv2.FastFeatureDetector_create()
    kp2 = fast2.detect(gray2,None)

    out2 = cv2.drawKeypoints(gray2,kp2,None, color = (255,0,0))

    cv2.imshow("original FAST", out)
    cv2.imshow("rotate FAST", out2)
    cv2.waitKey(0)

def rot_Harris(path):
    #convert to gray scale
    img = cv2.imread(path)
    gray = cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
    
    #harris corner detection
    gray = np.float32(gray)
    dst = cv2.cornerHarris(gray,2,3,0.04)
    dst = cv2.dilate(dst,None)
    img[dst>0.01*dst.max()]=[0,0,255]
    

    #rotate and doing detection again
    img2 = cv2.imread(path)
    img2 = cv2.rotate(img2,cv2.ROTATE_90_COUNTERCLOCKWISE)
    gray2 = cv2.cvtColor(img2,cv2.COLOR_BGR2GRAY)
    

    
    
    gray2 = np.float32(gray2)

    dst2 = cv2.cornerHarris(gray2,2,3,0.04)
    dst2 = cv2.dilate(dst2,None)
    img2[dst2>0.01*dst2.max()] = [0,0,255]


    cv2.imshow("original Harris",img)
    cv2.imshow("rotate Harris", img2)


    cv2.waitKey(0)


def rot_ORB(path):
    
    #convert into gray scale
    img = cv2.imread(path)
    gray = cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
    
    #perform ORB on original image
    orb = cv2.ORB_create()
    kp = orb.detect(gray,None)
    kp, des = orb.compute(gray,kp)
    out = cv2.drawKeypoints(gray,kp,None,color = (255,0,0),flags=0)

    #rotate image and perform ORB again
    img2 = cv2.rotate(img,cv2.ROTATE_90_COUNTERCLOCKWISE)
    gray2 = cv2.cvtColor(img2,cv2.COLOR_BGR2GRAY)
    
    orb2 = cv2.ORB_create()
    kp2 = orb2.detect(gray2,None)
    kp2, des2 = orb2.compute(gray2,kp2)
    out2 = cv2.drawKeypoints(gray2,kp2,None,color = (255,0,0), flags=0)




    cv2.imshow("original ORB",out)
    cv2.imshow("rotate ORB", out2)
    cv2.waitKey(0)



path = r'CSC391-B/Project2/part1/self-test.jpg'
rot_SIFT(path)
rot_FAST(path)
rot_Harris(path)
rot_ORB(path)

