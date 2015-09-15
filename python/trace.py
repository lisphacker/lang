#! /usr/bin/python

import sys
import linecache
import dis

def trace(fn):
    def tracefn(frame, event, arg):
        if event == 'call':
            print 'Initial locals: ', frame.f_locals
        elif event == 'line':
            lineno = frame.f_lineno
            file = frame.f_code.co_filename
            line = linecache.getline(file, lineno)

            
            print '  ', frame.f_locals
            print '{lineno}@{file}: {line}'.format(lineno=lineno,
                                                   file=file,
                                                   line=line)
        else:
            print 'Returning ', arg
            
        return tracefn
        
    def trace_applied_fn(*args, **kwargs):
        oldtracefn = sys.gettrace()
        sys.settrace(tracefn)
        ret = fn(*args, **kwargs)
        sys.settrace(oldtracefn)
        return ret

    return trace_applied_fn
        

@trace
def sum(l):
    s = 0
    for i in l:
        s += i


    return s

print sum([1, 2, 3, 4, 5])
        
        
