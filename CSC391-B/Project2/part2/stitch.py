# import the necessary packages
from panorama import Stitcher
import argparse
import imutils
import cv2
import numpy as np


def crop(result):


	stitched_img = cv2.copyMakeBorder(result, 10, 10, 10, 10, cv2.BORDER_CONSTANT, (0,0,0))

	gray = cv2.cvtColor(stitched_img, cv2.COLOR_BGR2GRAY)
	thresh_img = cv2.threshold(gray, 0, 255 , cv2.THRESH_BINARY)[1]



	contours = cv2.findContours(thresh_img.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

	contours = imutils.grab_contours(contours)
	areaOI = max(contours, key=cv2.contourArea)

	mask = np.zeros(thresh_img.shape, dtype="uint8")
	x, y, w, h = cv2.boundingRect(areaOI)
	cv2.rectangle(mask, (x,y), (x + w, y + h), 255, -1)

	minRectangle = mask.copy()
	sub = mask.copy()

	while cv2.countNonZero(sub) > 0:
		minRectangle = cv2.erode(minRectangle, None)
		sub = cv2.subtract(minRectangle, thresh_img)


	contours = cv2.findContours(minRectangle.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

	contours = imutils.grab_contours(contours)
	areaOI = max(contours, key=cv2.contourArea)

	

	x, y, w, h = cv2.boundingRect(areaOI)

	stitched_img = stitched_img[y:y + h, x:x + w]

	return stitched_img

# construct the argument parse and parse the arguments
ap = argparse.ArgumentParser()
ap.add_argument("-f", "--first", required=True,
	help="path to the first image")
ap.add_argument("-s", "--second", required=True,
	help="path to the second image")
ap.add_argument("-t", "--third", required=True,
	help="path to the third image")
ap.add_argument("-d", "--fourth", required=False,
	help="Feature detector ('sift','orb','harris','brisk')")
args = vars(ap.parse_args())


# load the two images and resize them to have a width of 400 pixels
# (for faster processing)
imageA = cv2.imread(args["first"])
imageB = cv2.imread(args["second"])
imageC = cv2.imread(args["third"])
detect = args["fourth"]


imageA = imutils.resize(imageA, width=400)
imageB = imutils.resize(imageB, width=400)
imageC = imutils.resize(imageC, width=400)

# stitch the images together to create a panorama
stitcher = Stitcher()

(result, vis) = stitcher.stitch([imageA, imageB], showMatches=True,num=2,detector="orb")

#result = crop(result)
cv2.imwrite("result.jpg",result)
img = cv2.imread("result.jpg")

(result2,vis2) = stitcher.stitch([img,imageC], showMatches=True,num=2,detector="orb")

#result2 = crop(result2)


#cv2.imwrite("result.jpg",result)

cv2.imshow("Image A", imageA)
cv2.imshow("Image B", imageB)
cv2.imshow("Image C", imageC)

cv2.imshow("result2", result2)
#cv2.imwrite("SIFT-result.jpg",result2)



'''
# show the images



(result2, vis2) = stitcher.stitch([imageB, imageC], showMatches=True,num=2)
cv2.imshow("Keypoint Matches", vis2)
cv2.imshow("Result", result)
cv2.imshow("result2", result2)
#cv2.imshow("all", test)

'''




cv2.waitKey(0)
