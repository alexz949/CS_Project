# import the necessary packages
from panorama import Stitcher
import argparse
import imutils
import cv2
import numpy as np



# construct the argument parse and parse the arguments
ap = argparse.ArgumentParser()
ap.add_argument("-f", "--first", required=True,
    help="path to the first image")
ap.add_argument("-s", "--second", required=True,
    help="path to the second image")
ap.add_argument("-t", "--third", required=True,
    help="path to the third image")

args = vars(ap.parse_args())


# load the three images and resize them to have a width of 400 pixels
# (for faster processing)
imageA = cv2.imread(args["first"])
imageB = cv2.imread(args["second"])
imageC = cv2.imread(args["third"])
#choosing which feature matcher to use by editing 'harris' ,'sift', 'orb', 'brisk'
det = "harris"

imageA = imutils.resize(imageA, width=400)
imageB = imutils.resize(imageB, width=400)
imageC = imutils.resize(imageC, width=400)

# stitch the images together to create a panorama
stitcher = Stitcher()

#stitching
(result, vis) = stitcher.stitch([imageA, imageB], showMatches=True,num=2,detector=det,crop=True)
(result2, vis2) = stitcher.stitch([result, imageC], showMatches=True,num=2,detector=det,crop=False)




#showing input and ouput
cv2.imshow("Image A", imageA)
cv2.imshow("Image B", imageB)
cv2.imshow("Image C", imageC)
cv2.imshow("result2", result2)

#write the output
#cv2.imwrite("result.jpg",result2)

cv2.waitKey(0)

