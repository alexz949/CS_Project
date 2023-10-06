import numpy as np
import cv2

ga = 0.1

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
    kp,des1 = sift.detectAndCompute(gray,None)
    out = cv2.drawKeypoints(gray,kp,img)

    #decrease the illumination
    img2 = cv2.imread(path)
    img2 = adjust_gamma(img2,ga)

    #do SIFT
    gray2  = cv2.cvtColor(img2,cv2.COLOR_BGR2GRAY)
    sift2 = cv2.SIFT_create()
    kp2,des2 = sift2.detectAndCompute(gray2,None)
    out2 = cv2.drawKeypoints(gray2,kp2,img2)



    cv2.imshow("original SIFT",out)
    cv2.imshow("illuminated SIFT",out2)

    cv2.waitKey(0)
    cv2.destroyAllWindows()
     # create BFMatcher object
    bf = cv2.BFMatcher()

    # Match descriptors.
    matches = bf.match(des1,des2)
    
    # sort the matches based on distance
    matches = sorted(matches, key=lambda val: val.distance)
    
    good_matches = []
    for m in matches:
        if m.distance < 1:
            good_matches.append(m)
    print(len(matches))
    print(len(des2))
    # Draw first 50 matches.
    out = cv2.drawMatches(img, kp, img2, kp2, matches[200:300], None, flags=2)
    cv2.imshow("test", out)
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
    img2 = adjust_gamma(img2,ga)

    #apply FAST
    gray2  = cv2.cvtColor(img2,cv2.COLOR_BGR2GRAY)
    fast2 = cv2.FastFeatureDetector_create()
    kp2 = fast2.detect(gray2,None)

    sift = cv2.SIFT_create()
    _,des1 = sift.compute(img2,kp)
    _,des2 = sift.compute(img2,kp2)


    out2 = cv2.drawKeypoints(gray2,kp2,None, color = (255,0,0))

    cv2.imshow("original FAST", out)
    cv2.imshow("illuminated FAST", out2)
    cv2.waitKey(0)

     # create BFMatcher object
    bf = cv2.BFMatcher()

    # Match descriptors.
    matches = bf.match(des1,des2)
    print(len(des1))
    print(len(matches))
    # sort the matches based on distance
    matches = sorted(matches, key=lambda val: val.distance)
    print(len(matches))
    # Draw first 50 matches.
    out = cv2.drawMatches(img, kp, img2, kp2, matches[0:1000], None, flags=2)

    cv2.imshow("test",out)
    cv2.waitKey(0)




def ill_Harris(path):
    print("hello world")
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
    cv2.imshow('Harris Keypoints', image_with_keypoints)
    cv2.waitKey(0)

    #decrease the illumination
    img2 = cv2.imread(path)
    img2 = adjust_gamma(img2,ga)

     #do harris
    gray2  = cv2.cvtColor(img2,cv2.COLOR_BGR2GRAY)

    gray2 = np.float32(gray2)
    dst2 = cv2.cornerHarris(gray2,2,3,0.04)
    dst2 = cv2.dilate(dst2,None)
    
    gray2 = cv2.normalize(gray2, None, 0, 255, cv2.NORM_MINMAX).astype('uint8')
    kp2 = np.argwhere(dst2 > 0.01 * dst2.max())
    kp2 = [cv2.KeyPoint(float(x[1]), float(x[0]), 3) for x in kp2]


    
    image_with_keypoints = cv2.drawKeypoints(img2,kp2, None, color=(255,0, 0), flags=cv2.DRAW_MATCHES_FLAGS_DEFAULT)
    cv2.imshow('Harris Keypoints', image_with_keypoints)
    cv2.waitKey(0)


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
    # Draw first 50 matches.
    out = cv2.drawMatches(img, kp1, img2, kp2, matches[1000:2000], None, flags=2)
    cv2.imshow("test", out)
    cv2.waitKey(0)





def ill_ORB(path):
    
    img = cv2.imread(path)
    gray = cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
    
    #perform ORB on original image
    orb = cv2.ORB_create()
    kp = orb.detect(gray,None)
    kp, des = orb.compute(gray,kp)
    out = cv2.drawKeypoints(gray,kp,None,color = (255,0,0),flags=0)

    #decrease the illumination
    img2 = cv2.imread(path)
    img2 = adjust_gamma(img2,ga)

    #do ORB
    gray2  = cv2.cvtColor(img2,cv2.COLOR_BGR2GRAY)

    orb2 = cv2.ORB_create()
    kp2 = orb2.detect(gray2,None)
    kp2, des2 = orb2.compute(gray2,kp2)
    out2 = cv2.drawKeypoints(gray2,kp2,None,color = (255,0,0), flags=0)




    

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

    cv2.imshow("ORB",out)
    cv2.waitKey(0)







path = "self-test.jpg"


ill_SIFT(path)
#ill_FAST(path)
#ill_Harris(path)
ill_ORB(path)





