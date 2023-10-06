import numpy as np
import cv2

#all four functions
def sca_SIFT(path):
    
    img = cv2.imread(path)
    gray= cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
    #Do SIFT for original image
    sift = cv2.SIFT_create()
    kp1,des1 = sift.detectAndCompute(gray,None)
    

    #scale image to 0.6 of original
    percent = 60

    img2 = cv2.imread(path)
    width = int(img2.shape[1] * percent / 100)
    length = int(img2.shape[0] * percent / 100)
    dim = (width, length)
    img2 = cv2.resize(img2,dim,interpolation=cv2.INTER_AREA)
    
    #Do SIFT after scaling
    gray2  = cv2.cvtColor(img2,cv2.COLOR_BGR2GRAY)
    sift2 = cv2.SIFT_create()
    kp2,des2 = sift2.detectAndCompute(gray2,None)
    

    # create BFMatcher object
    bf = cv2.BFMatcher()

    # Match descriptors.
    matches = bf.knnMatch(des1,des2,k=2)
    
    # sort the matches based on distance
    
    print(len(matches))
    # Apply ratio test
    good_matches = []
    for m,n in matches:
        if m.distance < 0.8*n.distance:
            good_matches.append([m])
    print(len(good_matches))
    # Draw matches.
    out = cv2.drawMatchesKnn(img, kp1, img2, kp2, matches[50:150], None, flags=2)

    cv2.imshow("sca SIFT",out)
    cv2.waitKey(0)



def sca_FAST(path):
    
    img = cv2.imread(path)
    gray = cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)

    #Do FAST on original image with nonmax suppression
    fast = cv2.FastFeatureDetector_create()
    kp = fast.detect(gray,None)
    out = cv2.drawKeypoints(gray, kp, None, color=(255,0,0))


    #Scale to 0.6
    percent = 60

    img2 = cv2.imread(path)
    width = int(img2.shape[1] * percent / 100)
    length = int(img2.shape[0] * percent / 100)
    dim = (width, length)
    img2 = cv2.resize(img2,dim,interpolation=cv2.INTER_AREA)

    #Do FAST after scaling
    gray2  = cv2.cvtColor(img2,cv2.COLOR_BGR2GRAY)
    fast2 = cv2.FastFeatureDetector_create()
    kp2 = fast2.detect(gray2,None)
    
    #Get descripto using SIFT
    out2 = cv2.drawKeypoints(gray2,kp2,None, color = (255,0,0))
    sift = cv2.SIFT_create()
    _,des1 = sift.compute(gray,kp)
    _,des2 = sift.compute(gray2,kp2)
    #drawing the keypoint
    '''
    cv2.imshow("ori",out)
    cv2.imshow("scale", out2)
    cv2.waitKey(0)
    '''
    # create BFMatcher object
    bf = cv2.BFMatcher()

    # Match descriptors.
    matches = bf.knnMatch(des1,des2,k=2)
    
    # sort the matches based on distance
    
    print(len(matches))
    # Apply ratio test
    good_matches = []
    for m,n in matches:
        if m.distance < 0.9*n.distance:
            good_matches.append([m])
    print(len(good_matches))
    # Draw matches.
    out = cv2.drawMatchesKnn(img, kp, img2, kp2, matches[1000:1500], None, flags=2)

    cv2.imshow("sca FAST",out)
    cv2.waitKey(0)





def sca_Harris(path):
    
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
    #drawing the keypoint
    '''
    image_with_keypoints = cv2.drawKeypoints(img,kp1, None, color=(255,0, 0), flags=cv2.DRAW_MATCHES_FLAGS_DEFAULT)
    cv2.imshow('Harris Keypoints', image_with_keypoints)
    cv2.waitKey(0)
    '''



    #do harris after skrink to 0.6
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
    # convert coordinates to Keypoint type
    gray2 = cv2.normalize(gray2, None, 0, 255, cv2.NORM_MINMAX).astype('uint8')
    kp2 = np.argwhere(dst2 > 0.01 * dst2.max())
    kp2 = [cv2.KeyPoint(float(x[1]), float(x[0]), 3) for x in kp2]

    '''
    #drwaing
    image_with_keypoints = cv2.drawKeypoints(img2,kp2, None, color=(255,0, 0), flags=cv2.DRAW_MATCHES_FLAGS_DEFAULT)
    cv2.imshow('Harris Keypoints', image_with_keypoints)
    cv2.waitKey(0)
    '''

    # compute SIFT descriptors from corner keypoints
    sift = cv2.SIFT_create()

    _,des2 = sift.compute(gray2,kp2)

    # create BFMatcher object
    bf = cv2.BFMatcher()

    # Match descriptors.
    matches = bf.knnMatch(des1,des2,k=2)
    
    # sort the matches based on distance
    
    print(len(matches))
    # Apply ratio test
    good_matches = []
    for m,n in matches:
        if m.distance < 0.8*n.distance:
            good_matches.append([m])
    print(len(good_matches))
    # Draw matches.
    out = cv2.drawMatchesKnn(img, kp1, img2, kp2, matches[1000:2000], None, flags=2)

    cv2.imshow("sca Harris",out)
    cv2.waitKey(0)


def sca_ORB(path):
    
    img = cv2.imread(path)
    gray = cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
    
    #perform ORB on original image
    orb = cv2.ORB_create()
    kp,des = orb.detectAndCompute(gray,None)
    out = cv2.drawKeypoints(gray,kp,None,color = (255,0,0),flags=0)



    #perform ORB after scale to 0.6
    percent = 60

    img2 = cv2.imread(path)
    width = int(img2.shape[1] * percent / 100)
    length = int(img2.shape[0] * percent / 100)
    dim = (width, length)
    img2 = cv2.resize(img2,dim,interpolation=cv2.INTER_AREA)

    #do ORB after scaling
    gray2  = cv2.cvtColor(img2,cv2.COLOR_BGR2GRAY)
    orb2 = cv2.ORB_create()
    kp2,des2 = orb2.detectAndCompute(gray2,None)
    
    #out2 = cv2.drawKeypoints(gray2,kp2,None,color = (255,0,0), flags=0)

    

    # create BFMatcher object
    bf = cv2.BFMatcher()

    # Match descriptors.
    matches = bf.match(des,des2)
   
    # sort the matches based on distance
    matches = sorted(matches, key=lambda val: val.distance)
    good_matches = []
    for m in matches:
        if m.distance < 300:
            good_matches.append(m)
    print(len(matches))
    print(len(good_matches))
    print(len(des2))

    # Draw  matches.
    out = cv2.drawMatches(img, kp, img2, kp2, matches[50:150], None, flags=2)
    cv2.imshow("sca ORB", out)
    cv2.waitKey(0)



#test for calling functions
path = 'self-test.jpg'


sca_SIFT(path)
sca_FAST(path)
sca_Harris(path)

sca_ORB(path)


