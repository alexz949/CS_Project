import dlib
import cv2



#original image
#read the image and convert to gray scale
image = cv2.imread("test_main.jpg")

gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

#Use HOG detector to find face
hogFaceDetector = dlib.get_frontal_face_detector()
faces = hogFaceDetector(gray, 1)

#loop through each face and draw a rect around it
for (i, rect) in enumerate(faces):
    x = rect.left()
    y = rect.top()
    w = rect.right() - x
    h = rect.bottom() - y
    #draw a rectangle
    cv2.rectangle(image, (x, y), (x + w, y + h), (255, 255, 0), 2)
    

cv2.imshow("Original", image)




#translation
image = cv2.imread("test_shift.jpg")

gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

#HOG face detector
hogFaceDetector = dlib.get_frontal_face_detector()
faces = hogFaceDetector(gray, 1)

#looping
for (i, rect) in enumerate(faces):
    x = rect.left()
    y = rect.top()
    w = rect.right() - x
    h = rect.bottom() - y
    #draw a rectangle
    cv2.rectangle(image, (x, y), (x + w, y + h), (255, 255, 0), 2)
    
cv2.imshow("translation", image)


#rotation by 90 degree
image = cv2.imread("test_main.jpg")
image = cv2.rotate(image,cv2.ROTATE_90_CLOCKWISE)

gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

#HOG face detector
hogFaceDetector = dlib.get_frontal_face_detector()
faces = hogFaceDetector(gray, 1)

#looping
for (i, rect) in enumerate(faces):
    x = rect.left()
    y = rect.top()
    w = rect.right() - x
    h = rect.bottom() - y
    #draw a rectangle
    cv2.rectangle(image, (x, y), (x + w, y + h), (255, 255, 0), 2)
    

cv2.imshow("rotation", image)

#scale changes by 50 percent less
image = cv2.imread("test_main.jpg")

image = cv2.resize(image, (0, 0), fx = 0.5, fy = 0.5)

gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

#HOG face detector
hogFaceDetector = dlib.get_frontal_face_detector()
faces = hogFaceDetector(gray, 1)

#looping
for (i, rect) in enumerate(faces):
    x = rect.left()
    y = rect.top()
    w = rect.right() - x
    h = rect.bottom() - y
    #draw a rectangle
    cv2.rectangle(image, (x, y), (x + w, y + h), (255, 255, 0), 2)
    

cv2.imshow("scale changes", image)


cv2.waitKey(0)