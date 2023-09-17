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
    

    for i in range(k):
        np_img = np.insert(np_img, 0, np.reshape(np.zeros(n),(1,n)),axis=0)
        np_img = np.insert(np_img, len(np_img), np.reshape(np.zeros(n),(1,n)),axis=0)


    for  i in range(k):
        np_img = np.insert(np_img, 0, np.zeros(len(np_img)),axis=1)
        np_img = np.insert(np_img, len(np_img[0]),np.zeros(len(np_img)) ,axis=1)

    
    print(len(np_img))


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
    
    print(len(new_img))
    
    """
    
    print(len(new_img))
    #print(new_img)
    plt.subplot(121),plt.imshow(imgray),plt.title('Original')
    plt.xticks([]), plt.yticks([])
    plt.subplot(122),plt.imshow(new_img),plt.title('Blurred')
    plt.xticks([]), plt.yticks([])
    plt.show()
    """







def cv_conv(path,k):
    t = 2 * k+1
    img = cv2.imread(path)
    assert img is not None, "file could not be read, check with os.path.exists()"
    blur = cv2.blur(img,(t,t))
    #print(blur)
    #print(len(blur[0]))
    
    #print(len(blur))
    plt.subplot(121),plt.imshow(img),plt.title('Original')
    plt.xticks([]), plt.yticks([])
    plt.subplot(122),plt.imshow(blur),plt.title('Blurred')
    plt.xticks([]), plt.yticks([])
    plt.show()


    




def main():
    print("hello world")
    k = 2
    conv(r"CSC391-B\\Project1\\samurai.jpg",k)
    #cv_conv(r"CSC391-B\\Project1\\samurai.jpg",k)





if __name__ == "__main__":
    main()