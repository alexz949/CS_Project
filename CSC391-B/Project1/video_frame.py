# importing the required modules
import cv2
import numpy as np
  
# capturing from the first camera attached
cap = cv2.VideoCapture(0)
#init
gray = False
smooth = False
edge = False
#edge kernel
edge_kernel = np.array([[-1,-1,-1],[-1,8,-1],[-1,-1,-1]])

unsharp = False

# will continue to capture until 'q' key is pressed
while True:
    ret, frame = cap.read()
    frame = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

    img = frame
    
    #turn into grey scale  and do histEq
    if gray:
        img = cv2.equalizeHist(img)
    # smoothing using Gaussian
    if smooth:
        img = cv2.GaussianBlur(frame,(5,5),0)
    
    #unsharp by blur
    if unsharp:
        test = cv2.blur(frame,(5,5))
        img = frame + 5 * (frame-test)
        img[img>255] = 255
        img[img<0] = 0

    #edge detect
    if edge:
        img = cv2.filter2D(frame,-1,edge_kernel,)
      
    cv2.imshow('Original', frame)
    cv2.imshow('Var', img)
   
    #press h to histEq
    if cv2.waitKey(1) == ord('h'):
        gray = \
            not gray

    #press e to detect edge
    if cv2.waitKey(1) == ord('e'):
        edge = \
            not edge
    #press s to smooth
    if cv2.waitKey(1) == ord('s'):
        smooth = \
            not smooth
    #press u to unsharp
    if cv2.waitKey(1) == ord('u'):
        unsharp = \
            not unsharp

    #press q to quit
    if cv2.waitKey(1) == ord('q'):
        break
  
# Releasing all the resources
cap.release()
cv2.destroyAllWindows()