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


def histEq(path):
    #convert color image into gray image
    img = cv2.imread(path)
    np_img = cv2.cvtColor(img, cv2.COLOR_RGB2GRAY)
    
    #create histogram for original image
    hist = np.histogram(np_img.flatten(),bins = 256, range = [0,256])
    

    #setup cdf function
    size = len(hist)
    array_cdf = np.empty(0,dtype=np.uint8)
    array_cdf = np.append(array_cdf,hist[0])
    
    
    for i in range(1,size):
        array_cdf = np.append(array_cdf,array_cdf[i-1]+hist[i])
        
    
    
    t1 = array_cdf.max()
    t2 = array_cdf.min()
    t3 = t1-t2
    m = len(np_img)
    n = len(np_img[0])
    #histogram eqaution
    m_cdf = np.ma.masked_equal(array_cdf,0)
    m_cdf = (m_cdf - t2) * 255 / t3
    array_cdf = np.ma.filled(m_cdf,0).astype('uint8')


    np_img = array_cdf[np_img]
    
    #plotting
    """
    plt.hist(imgray.flatten(),256,[0,256])
    plt.xlim([0,256])
    plt.show()
    plt.plot
    plt.hist(np_img.flatten(),256,[0,256])
    plt.xlim([0,256])
    plt.show()
    """
    
    return np_img

#function for doing hist equalization with built-in function
def cv_hist_eq(path):
    img = cv2.imread(path)
    imgray = cv2.cvtColor(img, cv2.COLOR_RGB2GRAY)
    
    
    cv_hist = cv2.equalizeHist(imgray)
    


    #plotting
    """
    plt.hist(imgray_cv.flatten(),256,[0,256])
    plt.xlim([0,256])
    plt.show()

    plt.hist(cv_hist.flatten(),256,[0,256])
    plt.xlim([0,256])
    plt.show()
    """

    return cv_hist
    



#main function
def main():
    #given a path of an image
    path = r"rectest.jpg"


    tic = time.time()
    new_img = histEq(path)
    toc = time.time()
    print("My function: ", toc - tic)


    tic = time.time()
    cv_hist = cv_hist_eq(path)
    toc = time.time()
    print("built-in function: ", toc-tic)

    cv2.imshow("hist",new_img)
    cv2.imshow("built-in", cv_hist)
    cv2.waitKey(0)
    
if __name__ == "__main__":
    main()