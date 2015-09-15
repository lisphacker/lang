#! /usr/bin/env python

import sys
import numpy as np
import matplotlib.pyplot as plt

from core.data import XML, RegData

def pad2(n):
    p = n - 1
    while n > 0:
        n >>= 1
        p |= n
    return p + 1

def envelope(x):
    # Pad the data so that we can match the behaviour and results of filt1d
    xpad = np.zeros((pad2(x.size)), dtype = x.dtype)
    xpad[0:x.size] = x
    
    f1 = np.fft.rfft(xpad)
    f2 = f1 * 1j

    x1 = np.fft.irfft(f1)
    x2 = np.fft.irfft(f2)

    # Not needed
    #x1 /= x1.size
    #x2 /= x2.size

    ret = np.sqrt(x1 * x1 + x2 * x2)
    return ret[0:x.size]

def padded_fft_ifft(x):
    xpad = np.zeros((pad2(x.size)), dtype = x.dtype)
    xpad[0:x.size] = x

    ret = np.fft.irfft(np.fft.rfft(xpad))
    return ret[0:x.size], ret
    
def main1():
    t1 = np.sin(np.linspace(0, 100, 10000)) + 4

    t2 = np.fft.irfft(np.fft.rfft(t1))
    t3, t4 = padded_fft_ifft(t1)

    plt.figure()
    
    plt.subplot(2, 2, 1)
    plt.plot(t1)
    plt.title('Original signal')

    plt.subplot(2, 2, 2)
    plt.plot(t2)
    plt.title('Reconstruction without padding')

    plt.subplot(2, 2, 3)
    plt.plot(t3)
    plt.title('Reconstruction with padding')

    plt.subplot(2, 2, 4)
    plt.plot(t4)
    plt.title('Reconstruction showing padding')

    plt.show()

def main2():
    sin = np.sin(np.linspace(0, 1000, 10000))

    r = np.linspace(-20, 20, 10000)
    spike = 5 * np.exp(-(r * r)) + 3 * np.exp(-((r - 10) * (r - 10))) + np.exp(-((r + 10) * (r + 10)))

    t1 = sin * spike

    t2 = envelope(t1)

    t3 = t1 + 0.05 * np.random.randn(10000)

    t4 = envelope(t3)

    t5 = t3 + 3

    t6 = envelope(t5)
    

    rows = 4
    cols = 2
    
    plt.figure()
    
    plt.subplot(rows, cols, 1)
    plt.plot(sin)
    plt.title('Sin')
    
    plt.subplot(rows, cols, 2)
    plt.plot(spike)
    plt.title('Gaussians')

    plt.subplot(rows, cols, 3)
    plt.plot(t1)
    plt.title('Combined signal = (sin .* spike)')
    
    plt.subplot(rows, cols, 4)
    plt.plot(t2)
    plt.title('Envelope  of combined signal')
    
    plt.subplot(rows, cols, 5)
    plt.plot(t3)
    plt.title('Combined signal with noise added')
    
    plt.subplot(rows, cols, 6)
    plt.plot(t4)
    plt.title('Envelope  of noisy signal')
    
    plt.subplot(rows, cols, 7)
    plt.plot(t5)
    plt.title('Noisy signal with bias')
    
    plt.subplot(rows, cols, 8)
    plt.plot(t6)
    plt.title('Envelope of biased signal')
    
    plt.show()
    
if __name__ == '__main__':
    #main1()
    main2()
