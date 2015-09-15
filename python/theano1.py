import theano.tensor as T
from theano import function
import numpy as np

M = T.fmatrix('M')
v = T.fvector('v')
P = T.dot(M, v)
f = function([M, v], P)

a = np.array([[1, 2], [3, 4]], dtype=np.float32)
b = np.array([10, 100], dtype=np.float32)
print f(a, b)

