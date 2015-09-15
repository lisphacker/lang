#!/usr/bin/env python

class CoreException(Exception):
    '''
    Base exception class.
    '''

    def __init__(self, message, *args, **kw_args):
        '''
        Constructor.

        @param message: Message string. Can use formatting options compatible with str.format()
        @type  message: str

        @param args: Positional arguments
        @type  args: list

        @param kw_args: Keyword arguments
        @type  kw_args: dict
        '''
        
        self.message = message.format(*args, **kw_args)
        ''' Exception message.
        @type: str '''

    def __str__(self):
        return self.message


class TypeCheckException(CoreException):
    '''
    Parameter type check exception
    '''
    
def typechecked(*types):
    '''
    Function decorator for type checking parameters.

    Sample usage:
    @typechecked(int, list)
    def fn(a, b):
        #  a must be an int and b must be a list

    @typechecked(int, [int, list])
    def fn(a, b):
        # a must be an int, and b can be an int or a list

    @typechecked(None, float)
    def fn(a, b):
        # a is not checked and b must be a float

    @typechecked(object, int, float):
    def method(self, a, b):
        # self must be an object, a must be an int and b must be a float.


    For the moment, this decorator cannot be used to check types of parameters to constructors.
    
    @param types: Parametric list of types to be checked against (using isinstance). A list of types can be provided to check
    if a parameter is one of a set of types, or None to skip type checking for a parameter.
    @type  types: list of types
    '''
    
    def capture_fn(fn):
        code = fn.func_code
        
        param_names = code.co_varnames[:code.co_argcount]
        defaults = fn.func_defaults

        def type_checked_fn_applicator(*args, **kw_args):

            new_args = tuple()

            for i,pn in enumerate(param_names):
                if i < len(args):
                    if pn in kw_args:
                        raise TypeCheckException('Multiple values received for parameter {0}', pn)
                    new_args += (args[i],)
                else:
                    if pn in kw_args:
                        new_args += (kw_args[pn],)
                    else:
                        def_idx = i - (len(param_names) - len(defaults))
                        new_args += (defaults[def_idx],)
                    
            for i, (t, v) in enumerate(zip(types, new_args)):
                if t == None:
                    continue

                if isinstance(t, list) or isinstance(t, set):
                    found = False
                    for t2 in t:
                        if isinstance(v, t2):
                            found = True
                            break
                    if found:
                        continue
                        
                    raise TypeCheckException("Type of parameter '{0}' ({1}) does not match declared type {2}",
                                             param_names[i], v, t)
                else:
                    if not isinstance(v, t):
                        raise TypeCheckException("Type of parameter '{0}' ({1}) does not match declared type {2}",
                                                 param_names[i], v, t)
                    
            return apply(fn, new_args)
        return type_checked_fn_applicator
    return capture_fn









@typechecked(int, int, [int, float])
def add(a, b=1, c=20):
    print 'a =', a, ', b =', b ,', c =', c
    r = a + b + c
    return r

def sub(a, b=1, c=20):
    print 'a =', a, ', b =', b ,', c =', c
    r = a + b + c
    return r

print '##############'

add(10, 20)
print '--------------'
add(100)
print '--------------'
add(b=1000, a=10)
print '--------------'
add(10, c=100.1)
print '--------------'
add(10, 20, c=100.1)
print '--------------'
add(10, 20, 30, b=100.1)

