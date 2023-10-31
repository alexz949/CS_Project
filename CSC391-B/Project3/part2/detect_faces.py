import dlib
import cv2

#step1: read the image
image = cv2.imread("test_main.jpg")

#step2: converts to gray image
gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

#step3: get HOG face detector and faces
hogFaceDetector = dlib.get_frontal_face_detector()
faces = hogFaceDetector(gray, 1)

#step4: loop through each face and draw a rect around it
for (i, rect) in enumerate(faces):
    x = rect.left()
    y = rect.top()
    w = rect.right() - x
    h = rect.bottom() - y
    #draw a rectangle
    cv2.rectangle(image, (x, y), (x + w, y + h), (255, 255, 0), 2)
    
#step5: display the resulted image
cv2.imshow("Original", image)




#translation
image = cv2.imread("test_shift.jpg")

#step2: converts to gray image
gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

#step3: get HOG face detector and faces
hogFaceDetector = dlib.get_frontal_face_detector()
faces = hogFaceDetector(gray, 1)

#step4: loop through each face and draw a rect around it
for (i, rect) in enumerate(faces):
    x = rect.left()
    y = rect.top()
    w = rect.right() - x
    h = rect.bottom() - y
    #draw a rectangle
    cv2.rectangle(image, (x, y), (x + w, y + h), (255, 255, 0), 2)
    
#step5: display the resulted image
cv2.imshow("translation", image)


#rotation
image = cv2.imread("test_main.jpg")
image = cv2.rotate(image,cv2.ROTATE_90_CLOCKWISE)

#step2: converts to gray image
gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

#step3: get HOG face detector and faces
hogFaceDetector = dlib.get_frontal_face_detector()
faces = hogFaceDetector(gray, 1)

#step4: loop through each face and draw a rect around it
for (i, rect) in enumerate(faces):
    x = rect.left()
    y = rect.top()
    w = rect.right() - x
    h = rect.bottom() - y
    #draw a rectangle
    cv2.rectangle(image, (x, y), (x + w, y + h), (255, 255, 0), 2)
    
#step5: display the resulted image
cv2.imshow("rotation", image)

#scale changes
image = cv2.imread("test_main.jpg")

image = cv2.resize(image, (0, 0), fx = 0.5, fy = 0.5)
#step2: converts to gray image
gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

#step3: get HOG face detector and faces
hogFaceDetector = dlib.get_frontal_face_detector()
faces = hogFaceDetector(gray, 1)

#step4: loop through each face and draw a rect around it
for (i, rect) in enumerate(faces):
    x = rect.left()
    y = rect.top()
    w = rect.right() - x
    h = rect.bottom() - y
    #draw a rectangle
    cv2.rectangle(image, (x, y), (x + w, y + h), (255, 255, 0), 2)
    
#step5: display the resulted image
cv2.imshow("scale changes", image)


cv2.waitKey(0)