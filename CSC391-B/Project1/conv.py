import numpy as np
import cv2
from matplotlib import pyplot as plt
import time
def tic():
    #Homemade version of matlab tic and toc functions
    import time
    global startTime_for_tictoc
    startTime_for_tictoc = time.time()

def toc():
    import time
    if 'startTime_for_tictoc' in globals():
        print ("Elapsed time is " + str(time.time() - startTime_for_tictoc) + " seconds.")
    else:
        print ("Toc: start time not set")


def conv(path,k):
    t = 2 * k+1
    
    #convert color image into gray image and put it into np array
    img = cv2.imread(path)
    row = len(img)
    col = len(img[0])
    
    np_img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)         
    
    
    m = len(np_img)
    n = len(np_img[0])
    
    #extend the image size for boundray coundition
    #edge case everything pixel not in image is 0
    for i in range(k):
        np_img = np.insert(np_img, 0, np.reshape(np.zeros(n),(1,n)),axis=0)
        np_img = np.insert(np_img, len(np_img), np.reshape(np.zeros(n),(1,n)),axis=0)
        np_img = np.insert(np_img, 0, np.zeros(len(np_img)),axis=1)
        np_img = np.insert(np_img, len(np_img[0]),np.zeros(len(np_img)) ,axis=1)


    new_img = np.zeros((m,n),dtype=np.uint8)
   
    #Box Filter
    t1 = 0
    t2 = 0
    tic()
    for i in range(k,len(np_img)-k):  
        for q in range(k,len(np_img[0])-k):
            np_img[i-k:i+k+1, q-k,q+k+1]
            sum = 0
            for p in range(i-k,i+k+1):
                for l in range(q-k,q+k+1):
                    sum = sum + np_img[p][l]
            
            
            new_img[t1][t2] = sum // (t**2)
            
            t2 += 1
        t2 = 0
        
        t1+=1
 
    #sent array back to np array
    #return the np array
    toc()
    return new_img



#built in function for doing box filter
def cv_conv(path,k):
    kernel = np.empty(0)
    if k == 1:
        kernel = np.ones((3,3)) / 9
    elif k == 2:
        kernel = np.ones((5,5)) /25
    else:
        print("Wrong k value")
    img = cv2.imread(path)
    imgray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    
    blur = cv2.filter2D(imgray,-1,kernel)

    
    return blur


def main():
    
    #processing image
    img = cv2.imread(r"big-samu.jpg")

    imgray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

    tic = time.time()
    new_img = conv(r"big-samu.jpg",1)
    toc = time.time()
    print("my function: ",toc - tic)
    tic = time.time()
    blur = cv_conv(r"big-samu.jpg",1)
    toc = time.time()
    print("built-in function: ", toc - tic)

    #showing images
    cv2.imshow("Original",imgray)
    cv2.imshow("conv blur",new_img)
    cv2.imshow("built-in blur", blur)
    cv2.waitKey(0)




if __name__ == "__main__":
    main()