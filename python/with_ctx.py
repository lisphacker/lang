#! /usr/bin/python3

class Inc:
    def __init__(self, start = 0, inc = 1):
        self.val = start
        self.inc = inc

    @property
    def value(self):
        val, self.val = self.val, self.val + self.inc
        return val
    
    def __enter__(self):
        print('__enter__')
        return self

    def __exit__(self, exc_type, exc_value, traceback):
        print('__exit__')
        print(exc_type)
        print(exc_value)
        print(traceback)

with Inc() as inc:
    for i in range(10):
        print(inc.value)
        raise BaseException

