img = cv2.imread(path)
    gray= cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
    #Do SIFT for original image
    sift = cv2.SIFT_create()
    kp = sift.detect(gray,None)
    out = cv2.drawKeypoints(gray,kp,img)