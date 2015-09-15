#!/usr/bin/env python

import numpy as np
import scipy.signal as scisig
import matplotlib.pyplot as plt

def main():
    x = np.linspace(-20, 20, 100)

    a = x#np.sin(x)
    b = x#np.linspace(-np.pi, np.pi, 20)
    c = scisig.correlate(a, b, 'same')
    d = scisig.correlate(a, b, 'full')
    c /= c.size
    d /= d.size
    
    plt.figure()
    
    plt.subplot(411)
    plt.plot(a)
    plt.subplot(412)
    plt.plot(b)
    plt.subplot(413)
    plt.plot(c)
    plt.subplot(414)
    plt.plot(d)
    
    plt.show()

if __name__ == '__main__':
    main()
    
