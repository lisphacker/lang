#! /usr/bin/env python

import numpy as np
import math
import sys

from OpenGL.GL import *
from OpenGL.GLUT import *
from OpenGL.GLU import *

class Singleton(type):
    def __init__(cls, n, b, k):
        type.__init__(cls, n, b, k)
        cls.instance = None

    def __call__(cls, *args, **kwargs):
        if cls.instance is None:
            cls.instance = super(Singleton, cls).__call__(*args, **kwargs)
        return cls.instance
        

class Base(object):
    def __init__(self, *args, **kwargs):
        pass

class HasParent(Base):
    def __init__(self, parent=None, *args, **kwargs):
        super(HasParent, self).__init__(*args, **kwargs)
        
        self.parent = parent

class HasChildren(Base):
    def __init__(self, *args, **kwargs):
        super(HasChildren, self).__init__(*args, **kwargs)
        
        self.children = []

    def add_child(self, child):
        self.children.append(child)

        if isinstance(child, HasParent):
            child.parent = self

class Point3(Base):
    def __init__(self, x, y, z, *args, **kwargs):
        super(Point3, self).__init__(*args, **kwargs)

        self.x = x
        self.y = y
        self.z = z

class Matrix4x4(Base):
    def __init__(self, values, *args, **kwargs):
        super(Matrix4x4, self).__init__(*args, **kwargs)

        self.values = values.squeeze().T

    def __mul__(self, o):
        return Matrix4x4(values=np.dot(self.values, o.values))
                         
    def __imul__(self, o):
        self.values = np.dot(self.values, o.values)
        return self
                         
    @staticmethod
    def create_identity_matrix():
        return Matrix4x4(values=np.eye(4, dtype=np.float32))

    @staticmethod
    def create_translate_matrix(x, y, z):
        return Matrix4x4(values=np.array([[1, 0, 0, x],
                                          [0, 1, 0, y],
                                          [0, 0, 1, z],
                                          [0, 0, 0, 1]], dtype=np.float32))

    @staticmethod
    def create_rotate_matrix(x, y, z):
        cx = math.cos(x)
        sx = math.sin(x)

        cy = math.cos(y)
        sy = math.sin(y)
        
        cz = math.cos(z)
        sz = math.sin(z)
                
        xrot = np.array([[1,  0,  0,  0],
                         [0, cx, -sx, 0],
                         [0, sx,  cx, 0],
                         [0,  0,  0,  1]], dtype=np.float32)
        yrot = np.array([[ cy, 0, sy, 0],
                         [  0, 1,  0, 0],
                         [-sy, 0, cy, 0],
                         [  0, 0,  0, 1]], dtype=np.float32)
        zrot = np.array([[cz, -sz, 0, 0],
                         [sz,  cz, 0, 0],
                         [ 0,   0, 1, 0],
                         [ 0,   0, 0, 1]], dtype=np.float32)
        rot = np.dot(xrot, np.dot(yrot, zrot))

        return Matrix4x4(values=rot, dtype=np.float32)


class Node(HasParent):
    def __init__(self, *args, **kwargs):
        super(Node, self).__init__(*args, **kwargs)

    def draw_apply(self):
        self.draw_begin()
        
        if isinstance(self, HasChildren):
            for child in self.children:
                child.draw_apply()

        self.draw()
        self.draw_end()

    def draw_begin(self):
        pass

    def draw(self):
        pass

    def draw_end(self):
        pass

class Group(Node, HasChildren):
    def __init__(self, *args, **kwargs):
        Node.__init__(self, *args, **kwargs)
        HasChildren.__init__(self, *args, **kwargs)

class Graphic(Node):
    def __init__(self, *args, **kwargs):
        super(Graphic, self).__init__(*args, **kwargs)

class Geometry(Graphic):
    def __init__(self, vertices, vertex_indices, *args, **kwargs):
        super(Geometry, self).__init__(*args, **kwargs)

        self.vertices = vertices
        self.vertex_indices = vertex_indices

        self.setup_geometry()

    def setup_geometry(self):
        self.vertex_buffer, self.vertex_index_buffer, self.vertex_color_buffer = glGenBuffers(3)

        glBindBuffer(GL_ARRAY_BUFFER, self.vertex_buffer)
        glBufferData(GL_ARRAY_BUFFER, self.vertices, GL_STATIC_DRAW)
        
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, self.vertex_index_buffer)
        glBufferData(GL_ELEMENT_ARRAY_BUFFER, self.vertex_indices, GL_STATIC_DRAW)

        self.vertex_colors = np.array(np.random.rand(len(self.vertices)), dtype=np.float32)
        
            
        glBindBuffer(GL_ARRAY_BUFFER, self.vertex_color_buffer)
        glBufferData(GL_ARRAY_BUFFER, self.vertex_colors, GL_STATIC_DRAW)
        
class QuadSet(Geometry):
    def __init__(self, vertices, vertex_indices, *args, **kwargs):
        super(QuadSet, self).__init__(vertices=vertices,
                                      vertex_indices=vertex_indices,
                                      *args, **kwargs)

    def draw(self):
        glEnableVertexAttribArray(0)
        
        glBindBuffer(GL_ARRAY_BUFFER, self.vertex_buffer)
        glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, None)

        #glBindBuffer(GL_ARRAY_BUFFER, self.vertex_color_buffer)
        #glColorPointer(4, GL_FLOAT, 0, None)

        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, self.vertex_index_buffer)
        glDrawElements(GL_QUADS, 24, GL_UNSIGNED_SHORT, None)

        glDisableVertexAttribArray(0)

class Cube(QuadSet):
    def __init__(self, size, *args, **kwargs):
        vertices, vertex_indices = self.create_geometry(size)

        super(QuadSet, self).__init__(vertices=vertices,
                                      vertex_indices=vertex_indices,
                                      *args, **kwargs)

    @staticmethod
    def create_geometry(size):
        sz = float(size) / 2
        vertices = np.array([[-sz, -sz, -sz],
                             [-sz,  sz, -sz],
                             [ sz,  sz, -sz],
                             [ sz, -sz, -sz],
                             [-sz, -sz,  sz],
                             [-sz,  sz,  sz],
                             [ sz,  sz,  sz],
                             [ sz, -sz,  sz]], dtype=np.float32).flatten()
        vertex_indices = np.array([[0, 1, 2, 3],
                                   [4, 5, 6, 7],
                                   [0, 1, 5, 4],
                                   [1, 2, 6, 5],
                                   [2, 3, 7, 6],
                                   [3, 0, 4, 7]], dtype=np.uint16).flatten()

        return vertices, vertex_indices
        
class TransformGroup(Group):
    def __init__(self, matrix=Matrix4x4.create_identity_matrix(), *args, **kwargs):
        super(TransformGroup, self).__init__(*args, **kwargs)

        self.matrix = matrix

    def draw_begin(self):
        glPushMatrix()
        #glLoadMatrixf(self.matrix.values)
        glMultMatrixf(self.matrix.values)

    def draw_end(self):
        glPopMatrix()

class World(Group):
    __metaclass__ = Singleton

    def __init__(self, *args, **kwargs):
        super(World, self).__init__(*args, **kwargs)

def init_world():
    world = World()
    rot_group = TransformGroup()
    trans_group = TransformGroup(matrix=Matrix4x4.create_translate_matrix(0, 0, -20))
    cube = Cube(10)

    rot_group.add_child(cube)
    trans_group.add_child(rot_group)
    world.add_child(trans_group)

def draw_fn():
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
    glLoadIdentity()					# Reset The View

    World().draw_apply()
    
    glutSwapBuffers()

def resize_fn(width, height):
    #return

    if height == 0:
        height = 1

    glViewport(0, 0, width, height)		# Reset The Current Viewport And Perspective Transformation
    glMatrixMode(GL_PROJECTION)
    glLoadIdentity()
    gluPerspective(45.0, float(width) / float(height), 0.1, 100.0)
    #gluLookAt(0, 30, 30,
    #          0, 0, 0,
    #          0, 0, 1)
    glMatrixMode(GL_MODELVIEW)

def kb_fn(key, x, y):
    if key == 27:
        sys.exit(0)

xa = 0.0
ya = 0.0
za = 0.0

def idle_fn():
    global xa, ya, za

    try:
        World().children[0].children[0].matrix = Matrix4x4.create_rotate_matrix(xa, ya, za)
    except:
        pass

    xa += 0.01
    ya += 0.02
    za += 0.03
    
    glutPostRedisplay()

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
    glClearColor(0.0, 0.0, 0.0, 0.0)	# This Will Clear The Background Color To Black
    glClearDepth(1.0)					# Enables Clearing Of The Depth Buffer
    glDepthFunc(GL_LESS)				# The Type Of Depth Test To Do
    glEnable(GL_DEPTH_TEST)				# Enables Depth Testing
    glShadeModel(GL_SMOOTH)				# Enables Smooth Color Shading

    resize_fn(width, height)

def main():
    w, h = 640, 480
    
    init_glut(w, h)
    init_gl(w, h)
    
    init_world()

    glutMainLoop()
    
    
if __name__ == '__main__':
    main()
