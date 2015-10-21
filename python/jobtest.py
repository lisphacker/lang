#!/usr/bin/env python

from joblib import Parallel, delayed
import os, time

def fn(x):
    print '>>>', x
    t = time.clock()
    while time.clock() < t + 2.0:
        pass
    print '<<<', x
    return (x, os.getpid())

def main():
    print Parallel(n_jobs=-1, verbose=True)(delayed(fn)(x) for x in range(20))

main()

