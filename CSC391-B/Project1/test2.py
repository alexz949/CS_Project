import numpy as np
test = np.empty((0,3))
new_row = np.array([1,2,3],dtype=int)
test = np.append(test,np.reshape(new_row,(1,3)), axis=0)
print(test)