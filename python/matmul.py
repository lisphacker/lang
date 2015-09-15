#! /usr/bin/env python

import numpy as np
import scipy as sp

def test_matmul(M, N, O):
    A = np.mat(np.random.rand(M, N))
    B = np.mat(np.random.rand(N, O))
    C = A * B
    return A, B, C

N = 000
test_matmul(N, N, N)
