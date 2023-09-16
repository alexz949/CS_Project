import numpy as np
import cv2
from matplotlib import pyplot as plt
import time 


def histEq(path):
    #convert color image into gray image
    img = cv2.imread(path)
    imgray = cv2.cvtColor(img, cv2.COLOR_RGB2GRAY)

    #create histogram for original image
    hist,bins = np.histogram(imgray.flatten(),bins = 256, range = [0,256])
    start = time.time()

    #setup cdf function
    size = len(hist)
    array_cdf = np.empty(size)
    array_cdf[0] = hist[0]
    for i in range(1,len(array_cdf)):
      array_cdf[i] = array_cdf[i-1] + hist[i]
    

    
    #histogram eqaution
    np_img = np.array(imgray)
    for i in range(len(np_img)):
        for j in range(len(np_img[0])):
            h = (int)((array_cdf[np_img[i][j]] - array_cdf.min()) / (array_cdf.max() - array_cdf.min()) * 255)
            np_img[i][j] = h
    
    end = time.time()

    print(end - start)
    #plotting
    plt.hist(imgray.flatten(),256,[0,256])
    plt.xlim([0,256])
    plt.show()
    plt.plot
    plt.hist(np_img.flatten(),256,[0,256])
    plt.xlim([0,256])
    plt.show()
    
    cv2.imshow('image', np_img)
    cv2.waitKey(0)

#function for doing hist equalization with built-in function
def cv_hist_eq(path):
    
    img_cv = cv2.imread(path)
    imgray_cv = cv2.cvtColor(img_cv, cv2.COLOR_RGB2GRAY)
    start = time.time()
    cv_hist = cv2.equalizeHist(imgray_cv)
    end = time.time()
    print(end - start)


    #plotting
    plt.hist(imgray_cv.flatten(),256,[0,256])
    plt.xlim([0,256])
    plt.show()

    plt.hist(cv_hist.flatten(),256,[0,256])
    plt.xlim([0,256])
    plt.show()

    cv2.imshow('cv_image',cv_hist)
    cv2.waitKey(0)
    



#main function
def main():
    #given a path of an image
    histEq(r"CSC391-B\\Project1\\big-samu.jpg")
    cv_hist_eq(r"CSC391-B\\Project1\\big-samu.jpg")


if __name__ == "__main__":
    main()