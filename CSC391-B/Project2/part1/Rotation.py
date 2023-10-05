import numpy as np
import cv2 

#This is for rotation part

def rot_SIFT(path):
    
    img = cv2.imread(path)
    gray= cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
    #Do SIFT for original image
    sift = cv2.SIFT_create()
    kp,feature1 = sift.detectAndCompute(gray,None)
    out = cv2.drawKeypoints(gray,kp,img)

    #rotate 90 degree counterclockwise  
    img2 = cv2.imread(path)
    img2 = cv2.rotate(img2,cv2.ROTATE_180)
    height, width = img2.shape[:2]
    center = (width/2, height/2)
    rotate_matrix = cv2.getRotationMatrix2D(center=center, angle=45, scale=1)
    img2 = cv2.warpAffine(src=img2, M=rotate_matrix, dsize=(width, height))
    gray2 = cv2.cvtColor(img2,cv2.COLOR_BGR2GRAY)
    '''

    ''' 


    #gray2 = cv2.cvtColor(img2,cv2.COLOR_BGR2GRAY)

    sift2 = cv2.SIFT_create()
    kp2, feature2 = sift2.detectAndCompute(gray2,None)
    out2 = cv2.drawKeypoints(gray2,kp2, img2)



    # create BFMatcher object
    bf = cv2.BFMatcher()

    # Match descriptors.
    matches = bf.match(feature1,feature2)
    print(len(kp))
    print(len(kp2))
    print(len(feature2))
    # sort the matches based on distance
    matches = sorted(matches, key=lambda val: val.distance)
    print(len(matches))
    # Draw first 50 matches.
    out = cv2.drawMatches(img, kp, img2, kp2, matches[450:500], None, flags=2)

    cv2.imshow("test",out)
    cv2.waitKey(0)



def rot_FAST(path):
    img = cv2.imread(path)
    gray= cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
    #Do SIFT for original image
    fast1 = cv2.FastFeatureDetector_create()
    sift1 = cv2.SIFT_create()
    kp1 = fast1.detect(gray,None)
    _,des1 = sift1.compute(gray,kp1)
    out = cv2.drawKeypoints(gray,kp1,img)

    #rotate 90 degree counterclockwise  
    img2 = cv2.imread(path)
    img2 = cv2.rotate(img2,cv2.ROTATE_180)
    height, width = img2.shape[:2]
    center = (width/2, height/2)
    rotate_matrix = cv2.getRotationMatrix2D(center=center, angle=45, scale=1)
    img2 = cv2.warpAffine(src=img2, M=rotate_matrix, dsize=(width, height))
    gray2 = cv2.cvtColor(img2,cv2.COLOR_BGR2GRAY)
    '''

    ''' 


    #gray2 = cv2.cvtColor(img2,cv2.COLOR_BGR2GRAY)

    fast2 = cv2.FastFeatureDetector_create()
    sift2 = cv2.SIFT_create()
    
    kp2 = fast2.detect(gray2,None)
    _,des2 = sift2.compute(gray2,kp2)

    out2 = cv2.drawKeypoints(gray2,kp2, img2)

    print(len(kp1))
    print(len(kp2))
    cv2.imshow("cool",out)
    cv2.imshow("cooool", out2)
    cv2.waitKey(0)

     # create BFMatcher object
    bf = cv2.BFMatcher()

    # Match descriptors.
    matches = bf.match(des1,des2)
    print(len(kp1))
    print(len(kp2))
    
    # sort the matches based on distance
    matches = sorted(matches, key=lambda val: val.distance)
    print(len(matches))
    # Draw first 50 matches.
    out = cv2.drawMatches(img, kp1, img2, kp2, matches[300:350], None, flags=2)

    cv2.imshow("test",out)
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
    img2 = cv2.rotate(img2,cv2.ROTATE_180)
    height, width = img2.shape[:2]
    center = (width/2, height/2)
    rotate_matrix = cv2.getRotationMatrix2D(center=center, angle=45, scale=1)
    img2 = cv2.warpAffine(src=img2, M=rotate_matrix, dsize=(width, height))
    gray2 = cv2.cvtColor(img2,cv2.COLOR_BGR2GRAY)
    

    
    
    gray2 = np.float32(gray2)

    dst2 = cv2.cornerHarris(gray2,2,3,0.04)
    dst2 = cv2.dilate(dst2,None)
    img2[dst2>0.01*dst2.max()] = [0,0,255]




    print(len(dst))
    print(len(dst2))
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
    img2 = cv2.imread(path)
    img2 = cv2.rotate(img2,cv2.ROTATE_180)
    height, width = img2.shape[:2]
    center = (width/2, height/2)
    rotate_matrix = cv2.getRotationMatrix2D(center=center, angle=45, scale=1)
    img2 = cv2.warpAffine(src=img2, M=rotate_matrix, dsize=(width, height))
    gray2 = cv2.cvtColor(img2,cv2.COLOR_BGR2GRAY)
    
    orb2 = cv2.ORB_create()
    kp2 = orb2.detect(gray2,None)
    kp2, des2 = orb2.compute(gray2,kp2)
    out2 = cv2.drawKeypoints(gray2,kp2,None,color = (255,0,0), flags=0)




    cv2.imshow("original ORB",out)
    cv2.imshow("rotate ORB", out2)
    cv2.waitKey(0)


    # create BFMatcher object
    bf = cv2.BFMatcher()

    # Match descriptors.
    matches = bf.match(des,des2)
    print(len(kp))
    print(len(kp2))
    
    # sort the matches based on distance
    matches = sorted(matches, key=lambda val: val.distance)
    print(len(matches))
    # Draw first 50 matches.
    out = cv2.drawMatches(img, kp, img2, kp2, matches[300:350], None, flags=2)

    cv2.imshow("test",out)
    cv2.waitKey(0)



path = "self-test.jpg"
#rot_SIFT(path)
#rot_FAST(path)
rot_Harris(path)
#rot_ORB(path)

