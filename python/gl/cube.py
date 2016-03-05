#! /usr/bin/env python

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
    def __init__(self, parent, *args, **kwargs):
        super(HasParent, self).__init__(*args, **kwargs)
        
        self.parent = parent

class HasChildren(Base):
    def __init__(self, parent, *args, **kwargs):
        super(HasChildren, self).__init__(*args, **kwargs)
        
        self.children = []

    def add_child(self, child):
        self.children.append(child)

        if isinstance(child, HasParent):
            chold.parent = self

class Point3(Base):
    def __init__(self, x, y, z, *args, **kwargs):
        super(Point3, self).__init__(*args, **kwargs)

        self.x = x
        self.y = y
        self.z = z

class Matrix4x4(Base):
    def __init__(self, values, *args, **kwargs):
        super(Matrix4x4, self).__init__(*args, **kwargs)

        self.values = values

    def __mul__(self, o):
        return Matrix4x4(values=np.dot(self.values, o.values))
                         
    def __imul__(self, o):
        self.values = np.dot(self.values, o.values)
        return self
                         
    @staticmethod
    def create_identity_matrix():
        return Matrix4x4(values=np.eye(4, dtype=np.float32))

class Node(HasParent):
    def __init__(self, *args, **kwargs):
        super(Node, self).__init__(*args, **kwargs)

class Group(HasParent, HasChildren):
    def __init__(self, *args, **kwargs):
        HasParent.__init__(*args, **kwargs)
        HasChildren.__init__(*args, **kwargs)

class Graphic(Node):
    def __init__(self, *args, **kwargs):
        super(Graphic, self).__init__(*args, **kwargs)

class Geometry(Graphic):
    def __init__(self, vertices, vertex_indices, *args, **kwargs):
        super(Geometry, self).__init__(*args, **kwargs)

        self.vertices = vertices
        self.vertex_indices = vertex_indices

class QuadSet(Geometry):
    def __init__(self, vertices, vertex_indices, *args, **kwargs):
        super(QuadSet, self).__init__(vertices=vertices,
                                      vertex_indices=vertex_indices,
                                      *args, **kwargs)

class Cube(QuadSet):
    def __init__(self, size, *args, **kwargs):
        vertices, vertex_indices = create_geometry(size)
        
        super(QuadSet, self).__init__(vertices=vertices,
                                      vertex_indices=vertex_indices,
                                      *args, **kwargs)

        @staticmethod
        def create_geometry(size):
            sz = size / 2
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
                                       [3, 0, 4, 7]], dtype=np.int32).flatten()

            return vertices, vertex_indices
        
class TransformGroup(Group):
    def __init__(self, matrix, *args, **kwargs):
        super(TransformGroup, self).__init__(*args, **kwargs)

        self.matrix = matrix

class World(Group):
    __metaclass__ = Singleton
