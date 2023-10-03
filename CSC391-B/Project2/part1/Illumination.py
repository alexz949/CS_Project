import numpy as np
import cv2


def adjust_gamma(image, gamma):

   invGamma = 1.0 / gamma
   table = np.array([((i / 255.0) ** invGamma) * 255
      for i in np.arange(0, 256)]).astype("uint8")

   return cv2.LUT(image, table)

def ill_SIFT(path):
    print("hello world")
    img = cv2.imread(path)
    gray= cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
    #Do SIFT for original image
    sift = cv2.SIFT_create()
    kp = sift.detect(gray,None)
    out = cv2.drawKeypoints(gray,kp,img)

    #decrease the illumination
    img2 = cv2.imread(path)
    img2 = adjust_gamma(img2,0.5)

    #do SIFT
    gray2  = cv2.cvtColor(img2,cv2.COLOR_BGR2GRAY)
    sift2 = cv2.SIFT_create()
    kp2 = sift2.detect(gray2,None)
    out2 = cv2.drawKeypoints(gray2,kp2,img2)



    cv2.imshow("original SIFT",out)
    cv2.imshow("illuminated SIFT",out2)

    cv2.waitKey(0)



def ill_FAST(path):
    print("hello world")    
    img = cv2.imread(path)
    gray = cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)

    #Do FAST on original image with nonmax suppression
    fast = cv2.FastFeatureDetector_create()
    kp = fast.detect(gray,None)
    out = cv2.drawKeypoints(gray, kp, None, color=(255,0,0))

    #decrease the illumination
    img2 = cv2.imread(path)
    img2 = adjust_gamma(img2,0.5)

    #apply FAST
    gray2  = cv2.cvtColor(img2,cv2.COLOR_BGR2GRAY)
    fast2 = cv2.FastFeatureDetector_create()
    kp2 = fast2.detect(gray2,None)

    out2 = cv2.drawKeypoints(gray2,kp2,None, color = (255,0,0))

    cv2.imshow("original FAST", out)
    cv2.imshow("illuminated FAST", out2)
    cv2.waitKey(0)




def ill_Harris(path):
    print("hello world")
    img = cv2.imread(path)
    gray = cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
    
    #harris corner detection
    gray = np.float32(gray)
    dst = cv2.cornerHarris(gray,2,3,0.04)
    dst = cv2.dilate(dst,None)
    img[dst>0.01*dst.max()]=[0,0,255]

    #decrease the illumination
    img2 = cv2.imread(path)
    img2 = adjust_gamma(img2,0.5)

     #do harris
    gray2  = cv2.cvtColor(img2,cv2.COLOR_BGR2GRAY)

    gray2 = np.float32(gray2)

    dst2 = cv2.cornerHarris(gray2,2,3,0.04)
    dst2 = cv2.dilate(dst2,None)
    img2[dst2>0.01*dst2.max()] = [0,0,255]


    cv2.imshow("original Harris",img)
    cv2.imshow("illuminated Harris", img2)

    cv2.waitKey(0)





def ill_ORB(path):
    print("hello world")
    img = cv2.imread(path)
    gray = cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
    
    #perform ORB on original image
    orb = cv2.ORB_create()
    kp = orb.detect(gray,None)
    kp, des = orb.compute(gray,kp)
    out = cv2.drawKeypoints(gray,kp,None,color = (255,0,0),flags=0)

    #decrease the illumination
    img2 = cv2.imread(path)
    img2 = adjust_gamma(img2,0.5)

    #do ORB
    gray2  = cv2.cvtColor(img2,cv2.COLOR_BGR2GRAY)

    orb2 = cv2.ORB_create()
    kp2 = orb2.detect(gray2,None)
    kp2, des2 = orb2.compute(gray2,kp2)
    out2 = cv2.drawKeypoints(gray2,kp2,None,color = (255,0,0), flags=0)




    cv2.imshow("original ORB",out)
    cv2.imshow("illuminated ORB", out2)
    cv2.waitKey(0)







path = r'CSC391-B/Project2/part1/self-test.jpg'


ill_SIFT(path)
ill_FAST(path)
ill_Harris(path)
ill_ORB(path)





