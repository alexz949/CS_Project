import numpy as np
test = np.arange(9).reshape(3,3)
new_row = np.array([1,2,3],dtype=int)
test = np.insert(test, len(test), new_row,axis=0)
test = np.insert(test, len(test), new_row,axis=0)
print(test)
new_row = np.zeros(5)
print(new_row)
test = np.insert(test, len(test[0]), new_row,axis=1)


print(test)