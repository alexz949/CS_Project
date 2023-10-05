import numpy as np
import cv2

def sca_SIFT(path):
    
    img = cv2.imread(path)
    gray= cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
    #Do SIFT for original image
    sift = cv2.SIFT_create()
    kp1,des1 = sift.detectAndCompute(gray,None)
    out = cv2.drawKeypoints(gray,kp1,img)

    #scale image to 0.75 of original and take an gaussian blur of 3 by 3
    percent = 60

    img2 = cv2.imread(path)
    width = int(img2.shape[1] * percent / 100)
    length = int(img2.shape[0] * percent / 100)
    dim = (width, length)
    img2 = cv2.resize(img2,dim,interpolation=cv2.INTER_AREA)
    #perform gaussian blur
    gray2  = cv2.cvtColor(img2,cv2.COLOR_BGR2GRAY)
    sift2 = cv2.SIFT_create()
    kp2,des2 = sift2.detectAndCompute(gray2,None)
    out2 = cv2.drawKeypoints(gray2,kp2,img2)



    # create BFMatcher object
    bf = cv2.BFMatcher()

    # Match descriptors.
    matches = bf.match(des1,des2)
    print(len(des1))
    print(len(des2))
    # sort the matches based on distance
    matches = sorted(matches, key=lambda val: val.distance)
    print(len(matches))
    # Draw first 50 matches.
    out = cv2.drawMatches(img, kp1, img2, kp2, matches[200:300], None, flags=2)

    cv2.imshow("test",out)
    cv2.waitKey(0)



def sca_FAST(path):
    
    img = cv2.imread(path)
    gray = cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)

    #Do FAST on original image with nonmax suppression
    fast = cv2.FastFeatureDetector_create()
    kp = fast.detect(gray,None)
    out = cv2.drawKeypoints(gray, kp, None, color=(255,0,0))


    #Scale to 0.75
    percent = 60

    img2 = cv2.imread(path)
    width = int(img2.shape[1] * percent / 100)
    length = int(img2.shape[0] * percent / 100)
    dim = (width, length)
    img2 = cv2.resize(img2,dim,interpolation=cv2.INTER_AREA)


    gray2  = cv2.cvtColor(img2,cv2.COLOR_BGR2GRAY)
    fast2 = cv2.FastFeatureDetector_create()
    kp2 = fast2.detect(gray2,None)

    out2 = cv2.drawKeypoints(gray2,kp2,None, color = (255,0,0))
    sift = cv2.SIFT_create()
    _,des1 = sift.compute(gray,kp)
    _,des2 = sift.compute(gray2,kp2)
    print(len(kp))
    print(len(kp2))
    cv2.imshow("original FAST", out)
    cv2.imshow("scale FAST", out2)
    cv2.waitKey(0)

    # create BFMatcher object
    bf = cv2.BFMatcher()

    # Match descriptors.
    matches = bf.match(des1,des2)
    print(len(des1))
    print(len(des2))
    # sort the matches based on distance
    matches = sorted(matches, key=lambda val: val.distance)
    print(len(matches))
    # Draw first 50 matches.
    out = cv2.drawMatches(img, kp, img2, kp2, matches[200:400], None, flags=2)

    cv2.imshow("test",out)
    cv2.waitKey(0)





def sca_Harris(path):
    
    img = cv2.imread(path)
    gray = cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
    
    #harris corner detection
    gray = np.float32(gray)
    dst = cv2.cornerHarris(gray,2,3,0.04)
    dst = cv2.dilate(dst,None)
    img[dst>0.01*dst.max()]=[0,0,255]


    #do harris after skrink to 0.75
    percent = 60

    img2 = cv2.imread(path)
    width = int(img2.shape[1] * percent / 100)
    length = int(img2.shape[0] * percent / 100)
    dim = (width, length)
    img2 = cv2.resize(img2,dim,interpolation=cv2.INTER_AREA)
    #do harris
    gray2  = cv2.cvtColor(img2,cv2.COLOR_BGR2GRAY)
    gray2 = np.float32(gray2)

    dst2 = cv2.cornerHarris(gray2,2,3,0.04)
    dst2 = cv2.dilate(dst2,None)
    img2[dst2>0.01*dst2.max()] = [0,0,255]
    print(len(dst))
    print(len(dst2))
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
    percent = 60

    img2 = cv2.imread(path)
    width = int(img2.shape[1] * percent / 100)
    length = int(img2.shape[0] * percent / 100)
    dim = (width, length)
    img2 = cv2.resize(img2,dim,interpolation=cv2.INTER_AREA)

    #do ORB
    gray2  = cv2.cvtColor(img2,cv2.COLOR_BGR2GRAY)
    orb2 = cv2.ORB_create()
    kp2 = orb2.detect(gray2,None)
    kp2, des2 = orb2.compute(gray2,kp2)
    out2 = cv2.drawKeypoints(gray2,kp2,None,color = (255,0,0), flags=0)

    


    cv2.imshow("original ORB",out)
    cv2.imshow("scaled ORB", out2)
    cv2.waitKey(0)

    # create BFMatcher object
    bf = cv2.BFMatcher()

    # Match descriptors.
    matches = bf.match(des,des2)
    print(len(des))
    print(len(matches))
    # sort the matches based on distance
    matches = sorted(matches, key=lambda val: val.distance)
    print(len(matches))
    # Draw first 50 matches.
    out = cv2.drawMatches(img, kp, img2, kp2, matches[200:300], None, flags=2)

    cv2.imshow("test",out)
    cv2.waitKey(0)




path = 'self-test.jpg'


sca_SIFT(path)
#sca_FAST(path)
#sca_Harris(path)
sca_ORB(path)


