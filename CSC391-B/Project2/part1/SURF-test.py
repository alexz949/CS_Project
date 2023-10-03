import cv2 as cv

img = cv.imread('C:\\Users\\Administrator\\Desktop\\CS_Project\\CSC391-B\\Project2\\part1\\big-samu-copy.jpg', cv.IMREAD_GRAYSCALE)
surf = cv.xfeatures2d.SURF_create(400)

kp, des = surf.detectAndCompute(img,None)


img2 = cv.drawKeypoints(img,kp,None,(255,0,0),4)

cv.imshow('SURF',img2)



img = cv.imread('CSC391-B/Project2/part1/big-samu-copy.jpg')
alpha = 1.5 # Contrast control
beta = 10 # Brightness control

# call convertScaleAbs function
img = cv.convertScaleAbs(img, alpha=alpha, beta=beta)

gray= cv.cvtColor(img,cv.COLOR_BGR2GRAY)
surf = cv.xfeatures2d.SURF_create(400)

kp, des = surf.detectAndCompute(gray,None)


img2 = cv.drawKeypoints(gray,kp,None,(255,0,0),4)

cv.imshow("bright", img2)


cv.waitKey(0)