import cv2


face_cascade = cv2.CascadeClassifier(
    f'{cv2.data.haarcascades}haarcascade_frontalface_default.xml')
#original image
frame = cv2.imread('woodcutters.jpg')
mask = cv2.imread('emoji.png')
gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
faces = face_cascade.detectMultiScale(gray, 1.08, 5)

for (x, y, w, h) in faces:
           
     # resize the mask

            ins = 0.5
            resized_mask = cv2.resize(mask, ((int)((1+ins)*w), (int)((1+ins)*h)))
            print(resized_mask.shape)

            # Adjust the mask position to match the face
            print(x)
            x_offset = int(x - 0.25*w)
            y_offset = int(y - 0.25*h)
            x_end = x_offset + resized_mask.shape[1]
            y_end = y_offset + resized_mask.shape[0]
            if x_end < frame.shape[1] and y_end < frame.shape[0]:
                for c in range(3):
                    frame[y_offset:y_end, x_offset:x_end, c] = resized_mask[:,:,c]
                frame = cv2.rectangle(frame, (x, y), (x+w, y+h), (255, 255, 0), 2)
    
cv2.imshow('Original', frame)
cv2.waitKey(0)