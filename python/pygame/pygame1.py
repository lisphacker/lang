#!/usr/bin/env python

import os, sys, time
import cProfile, pstats, StringIO
import pygame

pygame.init()

screen = pygame.display.set_mode((1280, 720))
grass = pygame.transform.scale(pygame.image.load('grasslight-big.png'), (32, 32))

for y in range(0, 720, 32):
    for x in range(0, 1280, 32):
        screen.blit(grass, (x, y))
        
pygame.display.flip()

time.sleep(3)
