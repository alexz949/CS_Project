# importing the required modules
import cv2
import numpy as np
  
# capturing from the first camera attached
cap = cv2.VideoCapture(0)
#init boolean
gray = False
smooth = False
edge = False
unsharp = False
#edge kernel
edge_kernel = np.array([[-1,-1,-1],[-1,8,-1],[-1,-1,-1]])

#main while loop
# will continue to capture until 'q' key is pressed
while True:
    #get frame
    ret, frame = cap.read()
    frame = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    img = frame
    #do histogram equalization
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
      
    #show video
    cv2.imshow('Original (press q to quit)', frame)
    cv2.imshow('Filter (press q to quit)', img)
   
    #press h to histEq
    keycode = cv2.waitKey(1)
    if keycode == 104:
        gray = \
            not gray

    #press e to detect edge
    elif keycode == 101:
        edge = \
            not edge
    #press s to smooth
    elif keycode == 115:
        smooth = \
            not smooth
    #press u to unsharp
    elif keycode == 117:
        unsharp = \
            not unsharp

    #press q to quit
    elif keycode == 113:
        break
  
# Releasing all the resources
cap.release()
cv2.destroyAllWindows()