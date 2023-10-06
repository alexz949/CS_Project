import cv2
import numpy as np
image1 = cv2.imread('tests1.jpg')
image2 = cv2.imread('tests2.jpg')
image3 = cv2.imread('tests3.jpg')

gray1 = cv2.cvtColor(image1, cv2.COLOR_BGR2GRAY)
gray2 = cv2.cvtColor(image2, cv2.COLOR_BGR2GRAY)
gray3 = cv2.cvtColor(image3, cv2.COLOR_BGR2GRAY)

orb = cv2.ORB_create()

# Find the keypoints and descriptors for each image
keypoints1, descriptors1 = orb.detectAndCompute(gray1, None)
keypoints2, descriptors2 = orb.detectAndCompute(gray2, None)
keypoints3, descriptors3 = orb.detectAndCompute(gray3, None)

bf = cv2.BFMatcher(cv2.NORM_HAMMING, crossCheck=True)

# Match descriptors between image 1 and image 2
matches1_2 = bf.match(descriptors1, descriptors2)

# Match descriptors between image 2 and image 3
matches2_3 = bf.match(descriptors2, descriptors3)

matches1_2 = sorted(matches1_2, key=lambda x: x.distance)
matches2_3 = sorted(matches2_3, key=lambda x: x.distance)

best_matches1_2 = matches1_2[:50]  # You can adjust the number of matches as needed
best_matches2_3 = matches2_3[:50]


src_pts = np.float32([keypoints1[m.queryIdx].pt for m in best_matches1_2]).reshape(-1, 1, 2)
dst_pts = np.float32([keypoints2[m.trainIdx].pt for m in best_matches1_2]).reshape(-1, 1, 2)

src_pts2 = np.float32([keypoints2[m.queryIdx].pt for m in best_matches2_3]).reshape(-1, 1, 2)
dst_pts2 = np.float32([keypoints3[m.trainIdx].pt for m in best_matches2_3]).reshape(-1, 1, 2)


M1, _ = cv2.findHomography(src_pts, dst_pts, cv2.RANSAC, 5.0)
M2, _ = cv2.findHomography(src_pts2, dst_pts2, cv2.RANSAC, 5.0)


height, width = image1.shape[:2]
warp1 = cv2.warpPerspective(image1, M1, (width + width, height))
warp2 = cv2.warpPerspective(image2, np.dot(M2, M1), (width + width, height))
warp3 = cv2.warpPerspective(image3, M2, (width + width, height))


mask = np.zeros((height, width * 2), dtype=np.uint8)
mask[:, :width] = 255


panorama = cv2.seamlessClone(warp1, warp2, mask, (width, height), cv2.NORMAL_CLONE)
panorama = cv2.seamlessClone(panorama, warp3, mask, (width, height), cv2.NORMAL_CLONE)


cv2.imshow('Stitched Panorama', panorama)
cv2.imwrite('panorama.jpg', panorama)
cv2.waitKey(0)
cv2.destroyAllWindows()
