#!/usr/bin/env python

import sys

## from HTMLParser import HTMLParser

## class DeHTMLParser(HTMLParser):
##     def __init__(self, *args, **kwargs):
##         HTMLParser.__init__(self, *args, **kwargs)
##         self.__text = ''
##         self.__tag_stack = []

##     def text(self):
##         return self.__text
    
##     def handle_starttag(self, tag, attrs):
##         print '>>', tag
##         self.__push(tag)
    
##     def handle_endtag(self, tag):
##         print '<<', tag
##         self.__pop()

##     def handle_data(self, data):
##         if self.__top() not in ['script', 'meta', 'style', 'a']:
##             print data

##     def __push(self, tag):
##         self.__tag_stack.insert(0, tag)
        
##     def __pop(self):
##         return self.__tag_stack.pop(0)

##     def __top(self):
##         try:
##             return self.__tag_stack[0]
##         except:
##             return ''
        

## def main2():
##     parser = DeHTMLParser()
##     parser.feed(sys.stdin.read())
##     sys.stdout.write(parser.text())





import xml.etree.ElementTree as ET
import re

blocked_tags = ['script', 'style']
def clean(node):
    if node.tag in blocked_tags:
        return None

    new_node = ET.Element(node.tag, node.attrib)
    new_node.text = node.text
    
    for child in node:
        new_child = clean(child)
        if new_child is not None:
            new_node.append(new_child)

    return new_node

def dump(node):
    print '>>>', node.tag

    if node.text is not None:
        print '***', node.text
        
    for child in node:
        dump(child)

    print '<<<', node.tag

def write(node):
    s = ''
    if node.text is not None:
        s += node.text.strip() + ' '
        
    for child in node:
        s += write(child)

    return s
        
def main():
    root = ET.XML(sys.stdin.read())
    new_root = clean(root)
    #dump(new_root)

    wordre = re.compile('[a-z]+')
    print wordre.findall(write(new_root).lower())
    
if __name__ == '__main__':
    main()
    
