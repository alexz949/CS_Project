import numpy as np
import cv2
test = np.ones((5,5))
print(test)
dst = np.zeros((5,5),dtype=np.uint8)
dst = cv2.integral(test)

d1 = cv2.integral(test[0:4,0:4])
d2 = cv2.integral(test[0,0])
d3 = cv2.integral(test[0,0:4])
d4 = cv2.integral(test[0:4,0])
print(dst)

dist = d1[len(d1)-1,len(d1[0])-1] + d2[len(d2)-1,len(d2[0])-1] - d3[len(d3)-1,len(d3[0])-1] - d4[len(d4)-1,len(d4[0])-1] 

print(dist)

