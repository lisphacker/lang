#! /usr/bin/env python3

import numpy as np

FFNNdtype = np.float32

DEFAULT_REGULARIZATION_FACTOR = 0.4
DEFAULT_LEARNING_RATE = 0.001

class FFNNActivationBase:
    pass

class FFNNSigmoid(FFNNActivationBase):
    def __init__(self):
        FFNNActivationBase.__init__(self)

    def __call__(self, x):
        return 1 / (1 + np.exp(0 - x))

class FFNNLayerBase:
    def __init__(self, **kw_args):
        if 'activator' in kw_args:
            self.activator = kw_args['activator']
        else:
            self.activator = FFNNSigmoid()

        self.z = None
        self.a = None

    def activate(self):
        self.a = self.activator(self.z)

class FFNNLayer(FFNNLayerBase):
    def __init__(self, num_nodes, num_outputs, **kw_args):
        FFNNLayerBase.__init__(self, **kw_args)

        self.regularization_factor = kw_args.get('regularization_factor', DEFAULT_REGULARIZATION_FACTOR)
        self.learning_rate = kw_args.get('learning_rate', DEFAULT_LEARNING_RATE)
            
        self.weights = np.array(0.01 * np.random.standard_normal((num_outputs, num_nodes)), dtype=FFNNdtype, order='F')
        self.bias_weights = np.array(0.01 * np.random.standard_normal((num_outputs, 1)), dtype=FFNNdtype, order='F')

        self.DELTA_W = np.zeros(self.weights.shape, dtype=FFNNdtype, order='F')
        self.DELTA_B = np.zeros(self.bias_weights.shape, dtype=FFNNdtype, order='F')

    def run_ff(self, output_layer):
        output_layer.z = np.dot(self.weights, self.a) + self.bias_weights.repeat(self.a.shape[1], 1)
        output_layer.activate()

    def compute_error(self, output_layer):
        self.error = np.dot(self.weights.T, output_layer.error) * self.a * (1 - self.a)
        
        self.delta_w = np.dot(output_layer.error, self.a.T)
        self.delta_b = output_layer.error.sum(1).reshape((output_layer.error.shape[0], 1))

        self.DELTA_W += self.delta_w
        self.DELTA_B += self.delta_b

    def update_weights(self, m):
        self.weights -= self.learning_rate * ((self.DELTA_W / m) + self.regularization_factor * self.weights)
        self.bias_weights -= self.learning_rate * (self.DELTA_B / m)
        
            
class FFNNOutputLayer(FFNNLayerBase):
    def __init__(self, num_nodes, **kw_args):
        FFNNLayerBase.__init__(self, **kw_args)

    def compute_error(self, outputs):
        diff = outputs - self.a

        self.sq_error = np.sum(diff * diff)
        self.error = -(diff) * self.a * (1 - self.a)

class FFNN:
    def __init__(self, layer_sizes, **kw_args):
        self.num_layers = len(layer_sizes)
        assert self.num_layers >= 2

        self.input_layer_idx = 0
        self.output_layer_idx = self.num_layers - 1

        self.layers = list()
        for l in range(self.num_layers):
            if l == self.output_layer_idx:
                layer = FFNNOutputLayer(layer_sizes[l], **kw_args)
            else:
                layer = FFNNLayer(layer_sizes[l], layer_sizes[l + 1], **kw_args)
                
            self.layers.append(layer)

    def train(self, inputs, outputs, num_iterations = 50):
        for it in range(num_iterations):
            self.run_ff(inputs)
            self.compute_error(outputs)
            print(self.layers[self.output_layer_idx].sq_error)
            self.update_weights(inputs)

    def run_ff(self, inputs):
        for l in range(0, self.num_layers - 1):
            if l == self.input_layer_idx:
                self.layers[self.input_layer_idx].a = inputs
                
            self.layers[l].run_ff(self.layers[l + 1])

    def compute_error(self, outputs):
        self.layers[self.output_layer_idx].compute_error(outputs)
        for l in range(self.num_layers - 2, -1, -1):
            self.layers[l].compute_error(self.layers[l + 1])
            
    
    def update_weights(self, inputs):
        for l in range(self.num_layers - 1):
            self.layers[l].update_weights(inputs.shape[1])

    def evaluate(self, input):
        in2 = input if len(input.shape) >= 2 else input.reshape((input.shape[0], 1))
        self.run_ff(in2)
        return self.layers[self.output_layer_idx].a
            
###################################################################################

M = 1000

from mpl_toolkits.mplot3d import axes3d
import matplotlib.pyplot as plt

def init_xor():
    inputs = np.array(np.random.random_integers(0, 1, size=(2, M)), dtype=FFNNdtype, order='F')
    outputs = np.array(np.logical_xor(inputs[0, :], inputs[1, :]), dtype=FFNNdtype).reshape((1, M))

    return inputs, outputs

def init_sin():
    inputs = np.array(np.random.rand(2, M), dtype=FFNNdtype, order='F')
    outputs = np.array((np.sin(np.pi * (inputs[0, :] + inputs[1, :]))), dtype=FFNNdtype).reshape((1, M))
    
    return inputs, outputs

def main():
    inputs, outputs = init_sin()

    nn = FFNN([2, 5, 2, 1])
    nn.train(inputs, outputs, 20000)

    N = 100
    b = np.array(np.linspace(0, 1, N), dtype=FFNNdtype, order='F')
    xx, yy = np.meshgrid(b, b)
    zz = np.empty(xx.shape, dtype=FFNNdtype, order='F')

    for i in range(xx.shape[0]):
        for j in range(xx.shape[1]):
            inp = np.array([xx[i, j], yy[i, j]], dtype=FFNNdtype, order='F').reshape((2, 1))
            zz[i, j] = nn.evaluate(inp)

    print(nn.layers[0].weights)
    print(nn.layers[0].bias_weights)
    
    print(nn.layers[1].weights)
    print(nn.layers[1].bias_weights)
    
    fig = plt.figure()
    plt.hold(True)
    ax = fig.add_subplot(111, projection='3d')
    ax.plot_wireframe(xx, yy, zz)
    ax.scatter(inputs[0, :], inputs[1, :], outputs[0, :], c='r')
    plt.xlim((0, 1))
    plt.ylim((0, 1))
    plt.show()
        
if __name__ == '__main__':
    main()
