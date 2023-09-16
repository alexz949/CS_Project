import numpy as np
import cv2
from matplotlib import pyplot as plt



def conv(path,k):
    
    #convert color image into gray image
    t = 2 * k+1
    img = cv2.imread(path)
    imgray = cv2.cvtColor(img, cv2.COLOR_RGB2GRAY)

    #convert img to np array
    np_img = np.array(imgray)
    m = len(np_img)
    n = len(np_img[0])
    print(m,n)
    

    
    
  
    
    num_img = []
    new_row = np.empty(0,dtype=np.uint8)
    for t1 in range(m-t):
        for t2 in range(n-t):
            sum = 0
            for p in range(t1,t1+t):
                for l in range(t2,t2+t):
                    sum = sum + np_img[p][l]
            
            sum = sum // (t*t)
            
    
            new_row = np.append(new_row,sum)
        num_img.append(new_row)
        new_row = np.empty(0,dtype=np.uint8)

 
    new_img = np.empty((m-t,n-t),dtype=np.uint8)
    for i in range(m-t):
        for j in range(n-t):
            new_img[i][j] = num_img[i][j]
    
    
    
    
    
    cv2.imshow('image_blur', new_img)
    
    cv2.imshow("original", imgray)

    cv2.waitKey(0)










    




def main():
    print("hello world")
    conv(r"CSC391-B\\Project1\\big-samu.jpg",4)





if __name__ == "__main__":
    main()