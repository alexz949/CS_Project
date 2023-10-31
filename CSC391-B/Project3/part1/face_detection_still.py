import cv2


face_cascade = cv2.CascadeClassifier(
    f'{cv2.data.haarcascades}haarcascade_frontalface_default.xml')
#original image
img = cv2.imread('test_main.jpg')
gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
faces = face_cascade.detectMultiScale(gray, 1.08, 5)
for (x, y, w, h) in faces:
    img = cv2.rectangle(img, (x, y), (x+w, y+h), (255, 255, 0), 2)
  
cv2.imshow('Original', img)

#translation
img = cv2.imread('test_shift.jpg')
gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
faces = face_cascade.detectMultiScale(gray, 1.08, 5)
for (x, y, w, h) in faces:
    img = cv2.rectangle(img, (x, y), (x+w, y+h), (255, 255, 0), 2)
  
cv2.imshow('translation', img)



#rotationq
img = cv2.imread('test_main.jpg')
img_90 = cv2.rotate(img, cv2.ROTATE_90_CLOCKWISE)
gray = cv2.cvtColor(img_90, cv2.COLOR_BGR2GRAY)
faces = face_cascade.detectMultiScale(gray, 1.08, 5)
for (x, y, w, h) in faces:
    img_90 = cv2.rectangle(img_90, (x, y), (x+w, y+h), (255, 255, 0), 2)
  

#cv2.imwrite('./woodcutters_detected.png', img)
cv2.imshow('90', img_90)

#scale changes
img = cv2.imread('test_main.jpg')

img_half = cv2.resize(img, (0, 0), fx = 0.5, fy = 0.5)

gray = cv2.cvtColor(img_half, cv2.COLOR_BGR2GRAY)
faces = face_cascade.detectMultiScale(gray, 1.08, 5)
for (x, y, w, h) in faces:
    img_half = cv2.rectangle(img_half, (x, y), (x+w, y+h), (255, 255, 0), 2)

cv2.imshow('half', img_half)
cv2.waitKey(0)
