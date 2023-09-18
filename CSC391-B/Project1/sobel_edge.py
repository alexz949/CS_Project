import cv2
import numpy as np

def sobel_edge_filter(path):
    #convert input image into gray image
    img = cv2.imread(path)
    imgray = cv2.cvtColor(img, cv2.COLOR_RGB2GRAY)

    #do edge detect
    #setup edge kernel
    kernel = np.array([[-1,-1,-1],[-1, 8,-1],[-1,-1,-1]])
    
    sharpened = cv2.filter2D(img, -1, kernel) 
    

    #do vertical sobel
    kernel = np.array([[1,0,-1],[2,0,-2],[1,0,-1]])
    sobel = cv2.filter2D(sharpened,-1,kernel)

    return sobel
    
    



def main():
    #read original image
    img = cv2.imread(r"big-samu.jpg")
    imgray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    new_img = sobel_edge_filter(r"big-samu.jpg")

    #output the value
    cv2.imshow("Original",imgray)
    cv2.imshow("Sobel_Edge",new_img)
    
    cv2.waitKey(0)





if __name__ == "__main__":
    main()