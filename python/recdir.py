#!/usr/bin/env python

import glob
import os.path as pth

def recenumdir(dir):
    dir_entries = glob.glob(dir + '/*')

    dirs = filter(pth.isdir, dir_entries)
    files = filter(pth.isfile, dir_entries)

    return files + (reduce(lambda z, x: z + x, [recenumdir(d) for d in dirs]) if dirs else [])

import pprint

pprint.pprint(recenumdir('/home/gautham/work/PIG'))
