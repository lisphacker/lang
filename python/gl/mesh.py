#! /usr/bin/env python

import numpy as np
import math
import sys

from OpenGL.GL import *
from OpenGL.GLUT import *
from OpenGL.GLU import *

def draw_fn():
    pass

class Shader:
    def __init__(self, source, shader_type):
        self.shader = glCreateShader(shader_type)
        glShaderSource(self.shader, source)

        glCompileShader(self.shader)

        status = None
        #glGetShaderiv(self.shader, GL_COMPILE_STATUS, status)
        status = glGetShaderiv(self.shader, GL_COMPILE_STATUS)
        if status == GL_FALSE:
            strInfoLog = glGetShaderInfoLog(self.shader)
            raise Exception('Shader compilation failed - ' + str(strInfoLog))

    def __del__(self):
        try:
            glDestroyShader(self.shader)
        except:
            pass
                            

class ShaderProgram:
    def __init__(self, shader_list):
        self.program = glCreateProgram()
        
        for shader in shader_list:
            glAttachShader(self.program, shader.shader)

        glLinkProgram(self.program)

        status = glGetProgramiv(self.program, GL_LINK_STATUS)
        if status == GL_FALSE:
            strInfoLog = glGetProgramInfoLog(self.program)
            raise Exception('Shader program link failed - ' + str(strInfoLog))

        for shader in shader_list:
            glDetachShader(self.program, shader.shader)

    def __self__(self):
        try:
            glDestroyProgram(self.program)
        except:
            pass

class Triangle:
    VERTEX_SHADER = '''
#version 330 core
layout(location = 0) in vec4 position;
void main()
{
   gl_Position = position;
}
'''

    FRAGMENT_SHADER = '''
#version 330 core
out vec4 outputColor;
void main()
{
   outputColor = vec4(1.0f, 1.0f, 1.0f, 1.0f);
}
'''

    def __init__(self):
        self.shader_program = ShaderProgram([Shader(self.VERTEX_SHADER, GL_VERTEX_SHADER),
                                             Shader(self.FRAGMENT_SHADER, GL_FRAGMENT_SHADER)])
        self.vertex_positions = np.array([0.75, 0.75, 0.0, 1.0,
                                          0.75, -0.75, 0.0, 1.0,
                                          -0.75, -0.75, 0.0, 1.0],
                                         dtype='float32')

        self.vertex_buffer_object = glGenBuffers(1)
        glBindBuffer(GL_ARRAY_BUFFER, self.vertex_buffer_object)
        glBufferData(GL_ARRAY_BUFFER, self.vertex_positions, GL_STATIC_DRAW)
        glBindBuffer(GL_ARRAY_BUFFER, 0)
        
triangle = None

def idle_fn():
    global triangle
    if triangle is None:
        triangle = Triangle()

    triangle.draw()
    
def resize_fn(width, height):
    if height == 0:
        height = 1

    glViewport(0, 0, width, height)    # Reset The Current Viewport And Perspective Transformation
    glMatrixMode(GL_PROJECTION)
    glLoadIdentity()
    #gluPerspective(45.0, float(width) / float(height), 0.1, 100.0)
    #gluLookAt(0, 30, 30,
    #          0, 0, 0,
    #          0, 0, 1)
    glMatrixMode(GL_MODELVIEW)
    glLoadIdentity()

def kb_fn():
    pass

def init_glut(width, height):
    glutInit(sys.argv)
    
    glutInitDisplayMode(GLUT_RGBA | GLUT_DOUBLE | GLUT_DEPTH)

    glutInitWindowSize(width, height)

    glutInitWindowPosition(0, 0)

    window = glutCreateWindow('Cube')

    glutDisplayFunc(draw_fn)

    glutIdleFunc(idle_fn)

    glutReshapeFunc(resize_fn)

    glutKeyboardFunc(kb_fn)

def init_gl(width, height):
    glClearColor(0.0, 0.0, 0.0, 0.0)   # This Will Clear The Background Color To Black
    glClearDepth(1.0)                  # Enables Clearing Of The Depth Buffer
    glDepthFunc(GL_LESS)               # The Type Of Depth Test To Do
    glEnable(GL_DEPTH_TEST)            # Enables Depth Testing
    glShadeModel(GL_SMOOTH)            # Enables Smooth Color Shading

    resize_fn(width, height)
    
def main():
    init_glut(800, 600)
    glutMainLoop()

if __name__ == '__main__':
    main()

    
