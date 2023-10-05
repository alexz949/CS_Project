import cv2
import numpy as np
import matplotlib.pyplot as plt

def plot_images(*imgs, figsize=(30,20), hide_ticks=False):
    '''Display one or multiple images.'''
    f = plt.figure(figsize=figsize)
    width = np.ceil(np.sqrt(len(imgs)))
    height = np.ceil(len(imgs) / width)
    for i, img in enumerate(imgs, 1):
        ax = f.add_subplot(height, width, i)
        if hide_ticks:
            ax.axis('off')
        ax.imshow(cv2.cvtColor(img, cv2.COLOR_BGR2RGB))


left = cv2.imread('tests1.jpg')
right = cv2.imread('tests2.jpg')




orb = cv2.ORB_create()

kp_left, des_left = orb.detectAndCompute(left, None)
kp_right, des_right = orb.detectAndCompute(right, None)

bf = cv2.BFMatcher(cv2.NORM_HAMMING, crossCheck=True)
matches = bf.match(des_left,des_right)

limit = 50
best = sorted(matches, key = lambda x:x.distance)[:limit]

left_pts = []
right_pts = []
for m in best:
    l = kp_left[m.queryIdx].pt
    r = kp_right[m.trainIdx].pt
    left_pts.append(l)
    right_pts.append(r)


M, _ = cv2.findHomography(np.float32(right_pts), np.float32(left_pts),cv2.RANSAC, 5.0)


dim_x = left.shape[1] + right.shape[1]
dim_y = max(left.shape[0], right.shape[0])
dim = (dim_x, dim_y)

warped = cv2.warpPerspective(right, M, dim)


comb = warped.copy()
# combine the two images
comb[0:left.shape[0],0:left.shape[1]] = left
# crop
r_crop = 1920
comb = comb[:, :r_crop]

cv2.imshow("result", comb)
cv2.waitKey(0)
