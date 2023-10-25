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
    img2 = cv2.rotate(img2,cv2.ROTATE_90_COUNTERCLOCKWISE)
    gray2 = cv2.cvtColor(img2,cv2.COLOR_BGR2GRAY)

    #do sift for rotated image
    sift2 = cv2.SIFT_create()
    kp2, feature2 = sift2.detectAndCompute(gray2,None)
    out2 = cv2.drawKeypoints(gray2,kp2, img2)


    # create BFMatcher object
    bf = cv2.BFMatcher()

    # Match descriptors.
    matches = bf.match(feature1,feature2)
    good_matches = []
    for m in matches:
        if m.distance < 0.75:
            good_matches.append(m)
    # sort the matches based on distance
    matches = sorted(matches, key=lambda val: val.distance)
    print(len(matches))
    
    print(len(good_matches))
    # Draw matches.
    out = cv2.drawMatches(img, kp, img2, kp2, matches[100:150], None, flags=2)

    cv2.imshow("rot sift",out)
    cv2.waitKey(0)



def rot_FAST(path):
    img = cv2.imread(path)
    gray= cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
    #Do FAST for original image, SIFT as descriptor
    fast1 = cv2.FastFeatureDetector_create()
    sift1 = cv2.SIFT_create()
    kp1 = fast1.detect(gray,None)
    _,des1 = sift1.compute(gray,kp1)
    out = cv2.drawKeypoints(gray,kp1,img)

    #rotate 90 degree counterclockwise  
    img2 = cv2.imread(path)
    img2 = cv2.rotate(img2,cv2.ROTATE_90_COUNTERCLOCKWISE)
   
    gray2 = cv2.cvtColor(img2,cv2.COLOR_BGR2GRAY)
    
    #Do FAST for rotated image and use SIFT as descriptor
    fast2 = cv2.FastFeatureDetector_create()
    sift2 = cv2.SIFT_create()
    
    kp2 = fast2.detect(gray2,None)
    _,des2 = sift2.compute(gray2,kp2)

    out2 = cv2.drawKeypoints(gray2,kp2, img2)

    

    # create BFMatcher object
    bf = cv2.BFMatcher()

    # Match descriptors.
    matches = bf.match(des1,des2)
    
    
    # sort the matches based on distance
    matches = sorted(matches, key=lambda val: val.distance)
    print(len(matches))
    #Find good matches
    good_matches = []
    for m in matches:
        if m.distance < 200:
            good_matches.append(m)
    print(len(good_matches))
    # Draw matches.
    out = cv2.drawMatches(img, kp1, img2, kp2, matches[0:50], None, flags=2)

    cv2.imshow("rot fast",out)
    cv2.waitKey(0)

    
    

def rot_Harris(path):
    #convert to gray scale
    img = cv2.imread(path)
    gray = cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
    
    #harris corner detection
    gray = np.float32(gray)
    dst = cv2.cornerHarris(gray,2,3,0.04)
    dst = cv2.dilate(dst,None)
    
    # convert coordinates to Keypoint type
    gray = cv2.normalize(gray, None, 0, 255, cv2.NORM_MINMAX).astype('uint8')
    kp1 = np.argwhere(dst > 0.01 * dst.max())
    kp1 = [cv2.KeyPoint(float(x[1]), float(x[0]), 3) for x in kp1]

    # compute SIFT descriptors from corner keypoints
    sift = cv2.SIFT_create()
    _,des1 = sift.compute(gray,kp1)
    image_with_keypoints = cv2.drawKeypoints(img,kp1, None, color=(255,0, 0), flags=cv2.DRAW_MATCHES_FLAGS_DEFAULT)
    

    #rotate and doing detection again
    img2 = cv2.imread(path)
    img2 = cv2.rotate(img2,cv2.ROTATE_90_COUNTERCLOCKWISE)
    gray2 = cv2.cvtColor(img2,cv2.COLOR_BGR2GRAY)
    
    gray2 = np.float32(gray2)
    dst2 = cv2.cornerHarris(gray2,2,3,0.04)
    dst2 = cv2.dilate(dst2,None)
    
    gray2 = cv2.normalize(gray2, None, 0, 255, cv2.NORM_MINMAX).astype('uint8')
    kp2 = np.argwhere(dst2 > 0.01 * dst2.max())
    kp2 = [cv2.KeyPoint(float(x[1]), float(x[0]), 3) for x in kp2]


    
    image_with_keypoints = cv2.drawKeypoints(img2,kp2, None, color=(255,0, 0), flags=cv2.DRAW_MATCHES_FLAGS_DEFAULT)
    

    # compute SIFT descriptors from corner keypoints
    sift = cv2.SIFT_create()

    _,des2 = sift.compute(gray2,kp2)

    # create BFMatcher object
    bf = cv2.BFMatcher()

    # Match descriptors.
    matches = bf.match(des1,des2)
   

    
    # sort the matches based on distance
    matches = sorted(matches, key=lambda val: val.distance)
    good_matches = []
    for m in matches:
        if m.distance < 0.75:
            good_matches.append(m)
    print(len(matches))
    print(len(good_matches))
    # Draw matches.
    out = cv2.drawMatches(img, kp1, img2, kp2, matches[:250], None, flags=2)
    cv2.imshow("rot harris", out)
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
    img2 = cv2.rotate(img2,cv2.ROTATE_90_COUNTERCLOCKWISE)
    
    gray2 = cv2.cvtColor(img2,cv2.COLOR_BGR2GRAY)
    
    orb2 = cv2.ORB_create()
    kp2 = orb2.detect(gray2,None)
    kp2, des2 = orb2.compute(gray2,kp2)
    out2 = cv2.drawKeypoints(gray2,kp2,None,color = (255,0,0), flags=0)



    # create BFMatcher object
    bf = cv2.BFMatcher()

    # Match descriptors.
    matches = bf.match(des,des2)
    
    
    # sort the matches based on distance
    matches = sorted(matches, key=lambda val: val.distance)
    print(len(matches))
    good_matches = []
    for m in matches:
        if m.distance < 0.1:
            good_matches.append(m)
    print(len(good_matches))
    # Draw matches.
    out = cv2.drawMatches(img, kp, img2, kp2, matches[400:450], None, flags=2)

    cv2.imshow("rot ORB",out)
    cv2.waitKey(0)



#call functions
path = "self-test.jpg"
rot_SIFT(path)
rot_FAST(path)
rot_Harris(path)
rot_ORB(path)

