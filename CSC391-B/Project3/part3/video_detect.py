import cv2


face_cascade = cv2.CascadeClassifier(
    f'{cv2.data.haarcascades}haarcascade_frontalface_default.xml')
eye_cascade = cv2.CascadeClassifier(
    f'{cv2.data.haarcascades}haarcascade_eye.xml')
mask = cv2.imread('skull.png', cv2.IMREAD_UNCHANGED)
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

            ins = 0.4
            resized_mask = cv2.resize(mask, ((int)((1+ins)*w), (int)((1+ins)*h)))
            
            mask_alpha = resized_mask[:, :, 3] / 255.0

            mask_inverse = 1.0 - mask_alpha

            mask_bgr = resized_mask[:, :, :3]
            # Adjust the mask position to match the face
            
            x_offset = int(x - 0.2*w)
            y_offset = int(y - 0.2*h)
            x_end = x_offset + resized_mask.shape[1]
            y_end = y_offset + resized_mask.shape[0]
            for c in range(3):
                frame[y_offset:y_end, x_offset:x_end, c] = (
                    mask_alpha * mask_bgr[:, :, c] +
                    mask_inverse * frame[y_offset:y_end, x_offset:x_end, c]
                )
            frame = cv2.rectangle(frame, (x, y), (x+w, y+h), (255, 255, 0), 2)

    cv2.imshow('Face Detection', frame)