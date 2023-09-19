import numpy as np
import cv2
from matplotlib import pyplot as plt
import time

#my function
def conv(path,k):
    t = 2 * k+1
    
    #convert color image into gray image and put it into np array
    img = cv2.imread(path)
    int_img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)  

    #init
    m = len(int_img)
    n = len(int_img[0]) 
    np_img = np.zeros((m+1,n+1))

    # Create Integral graph
    np_img = cv2.integral(int_img)    
    
    
    
    #extend the image size for boundray coundition
    #edge case everything pixel not in image is 0
    for i in range(k):
        np_img = np.insert(np_img, 0, np.reshape(np.zeros(len(np_img[0])),(1,len(np_img[0]))),axis=0)
        np_img = np.insert(np_img, len(np_img), np.reshape(np.zeros(len(np_img[0])),(1,len(np_img[0]))),axis=0)
        np_img = np.insert(np_img, 0, np.zeros(len(np_img)),axis=1)
        np_img = np.insert(np_img, len(np_img[0]),np.zeros(len(np_img)) ,axis=1)
    


    #init new image
    new_img = np.zeros((m,n),dtype=np.uint8)
    

    t1=0

    #box filter
    for i in range(k+1,m+k+1):  
        a = i-k-1
        b = i+k
        test1 = np_img[a,:]
        test2 = np_img[b,:]
        new_row = np.zeros(n)
        for j in range(k+1,n+k+1):
            c = test2[j+k] + test1[j-k-1] - test2[j-k-1] - test1[j+k]
            new_row[j-k-1] = c // t**2
        new_img[i-k-1,:] = np.add(new_img[i-k-1,:], new_row)
           
   
    
    
    #return the np array
    return new_img



#built-in function
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
    #blurring
    blur = cv2.filter2D(imgray,-1,kernel)
    

    return blur


def main():
    
    #processing image
    path = r"img_test.jpg"
    img = cv2.imread(path)
    imgray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

    # when k = 1, this creates a 3 by 3 filter, and k = 2, creating a 5 by 5 filter
    k = 2

    #time my function
    tic = time.time()
    new_img = conv(path,k)
    toc = time.time()
    print("my function: ",toc - tic)


    #time the built-in function
    tic = time.time()
    blur = cv_conv(path,k)
    toc = time.time()
    print("built-in function: ", toc - tic)




    #showing images
    cv2.imshow("Original",imgray)
    cv2.imshow("conv blur",new_img)
    cv2.imshow("built-in blur", blur)
    cv2.waitKey(0)
    




if __name__ == "__main__":
    main()