#! /usr/bin/env python

from aptsources.sourceslist import SourcesList as SL

sl = SL()

for se in sl:
    print se.__dict__
    print ''
