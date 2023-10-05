import cv2
import numpy as np 

path = "self-test.jpg"
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

sift =cv2.SIFT_create()
_,feature1 = sift.compute(img,dst)

_,feature2 = sift.compute(img2,dst2)


print(len(dst))
print(len(dst2))
cv2.imshow("original Harris",img)
cv2.imshow("rotate Harris", img2)
cv2.waitKey(0)


# create BFMatcher object
bf = cv2.BFMatcher()

# Match descriptors.
matches = bf.match(feature1, feature2)
 
# sort the matches based on distance
matches = sorted(matches, key=lambda val: val.distance)
print(len(matches))
# Draw first 50 matches.
out = cv2.drawMatches(img, dst, img2, dst2, matches[450:500], None, flags=2)

cv2.imshow("test",out)
cv2.waitKey(0)

