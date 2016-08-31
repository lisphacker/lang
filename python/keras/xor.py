import numpy as np

import matplotlib
matplotlib.use('TkAgg')

import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import axes3d

from keras.models import Sequential
from keras.layers import Dense, Activation

def completion_status(s, e):
    def capture_fn(fn):
        def wrapper_fn(*args):
            print s
            ret = fn(*args)
            print e
            return ret

        return wrapper_fn
    return capture_fn

def gen_data(n=5):
    i = np.random.randint(0, 2, size=(n, 2))
    o = i[:, 0] ^ i[:, 1]

    for (i1, i2), o1 in zip(i, o):
        print i1, i2, o1
    return np.array(i, dtype='float32'), np.array(o, dtype='float32')

@completion_status('Creating model', 'Model created')
def create_model():
    model = Sequential([Dense(2, input_dim=2),
                        Activation('sigmoid'),
                        Dense(2),
                        Activation('sigmoid'),
                        Dense(1),
                        Activation('sigmoid')])

    model.compile(optimizer='rmsprop',
                  loss='mse')

    return model

@completion_status('Training model', 'Training complete')
def train_model(model, inputs, outputs):
    model.fit(inputs, outputs)

@completion_status('Testing model', 'Testing complete')
def test_model(model, inputs, ref_outputs):
    model.evaluate(inputs, ref_outputs)

def plot(model):
    x = np.linspace(0, 1, 11, dtype='float32')
    y = np.linspace(0, 1, 11, dtype='float32')

    xx, yy = np.meshgrid(x, y)

    xf = xx.flatten()
    yf = yy.flatten()

    xy = np.empty((len(xf), 2), dtype='float32')
    xy[:, 0] = xf
    xy[:, 1] = yf

    z = model.predict(xy).reshape(xx.shape)

    fig = plt.figure()
    ax = fig.add_subplot(111, projection='3d')
    ax.plot_wireframe(xx, yy, z)

    print 'Plotting'
    plt.show()
    
    
def run(train_size=1000, test_size=100):
    train_inputs, train_outputs = gen_data(train_size)
    test_inputs, test_outputs = gen_data(test_size)
    
    model = create_model()
    train_model(model, train_inputs, train_outputs)
    #test_model(model, test_inputs, test_outputs)
    plot(model)
    
