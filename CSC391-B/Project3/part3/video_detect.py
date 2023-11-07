import cv2
import imutils
import numpy as np
from math import sqrt


def convex(src_img, raw, effect):
    col, row, channel = raw[:]
    cx, cy, r = effect[:]
    output = np.zeros([row, col, channel], dtype = np.uint8)
    for y in range(row):
        for x in range(col):
            d = ((x - cx) * (x - cx) + (y - cy) * (y - cy)) ** 0.5
            if d <= r:
                nx = int((x - cx) * d / r + cx)
                ny = int((y - cy) * d / r + cy)
                output[y, x, :] = src_img[ny, nx, :]
            else:
                output[y, x, :] = src_img[y, x, :]
    return output


face_cascade = cv2.CascadeClassifier(
    f'{cv2.data.haarcascades}haarcascade_frontalface_default.xml')
eye_cascade = cv2.CascadeClassifier(
    f'{cv2.data.haarcascades}haarcascade_eye.xml')
mask = cv2.imread('blank.png', cv2.IMREAD_UNCHANGED)
print("Here")
camera = cv2.VideoCapture(0)
while (cv2.waitKey(1) == -1):
    success, frame = camera.read()
    if success:
                 
        gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
        faces = face_cascade.detectMultiScale(
            gray, 1.1, 5, minSize=(120, 120))
        for (x, y, w, h) in faces:
           
     # resize the mask

            ins = 0.2
            resized_mask = cv2.resize(mask, ((int)((1+ins)*w), (int)((1+ins)*h)))
            
            mask_alpha = resized_mask[:, :, 3] / 255.0

            mask_inverse = 1.0 - mask_alpha

            mask_bgr = resized_mask[:, :, :3]
            # Adjust the mask position to match the face
            
            x_offset = int(x - 0.1*w)
            y_offset = int(y - 0.1*h)
            x_end = x_offset + resized_mask.shape[1]
            y_end = y_offset + resized_mask.shape[0]
            if x_end < frame.shape[1] and y_end < frame.shape[0]:
                for c in range(3):
                    frame[y_offset:y_end, x_offset:x_end, c] = (
                        mask_alpha * mask_bgr[:, :, c] +
                        mask_inverse * frame[y_offset:y_end, x_offset:x_end, c]
                    )
                    
            roi_gray = gray[y:y+h, x:x+w]
            eyes = eye_cascade.detectMultiScale(
                roi_gray, 1.09, 5, minSize=(40, 40))
            for (ex, ey, ew, eh) in eyes:  
                
                a, b = frame[y+ey:y+ey+eh,x+ex:x+ex+ew].shape[1],frame[y+ey:y+ey+eh,x+ex:x+ex+ew].shape[0]
                cw, ch = int(a/2), int(b/2)             
                frame[y+ey:y+ey+eh,x+ex:x+ex+ew] = convex(frame[y+ey:y+ey+eh,x+ex:x+ex+ew], (a, b, 3), (cw, ch, 100))
    
                

    cv2.imshow('Face Detection', frame)