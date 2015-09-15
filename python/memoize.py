#!/usr/bin/env python

def memoize(fn):
    memo = dict()
    def capture_fn(*args, **kwargs):
        if args in memo:
            return memo[args]
        else:
            result = apply(fn, args)
            memo[args] = result
            return result
        
    return capture_fn

import time

@memoize
def add(a, b):
    time.sleep(1)
    return a + b

print add(10, 20)
print add(10, 20)
print add(20, 20)
print add(20, 20)

