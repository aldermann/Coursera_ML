import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.backends import _macosx

layerLengths = [784, 15, 10]
layerCounts = len(layerLengths)
nn_theta = np.load("weight.npy", allow_pickle=True)

def sigmoid(A):
    return 1 / (1 + np.exp(-A))


def prependWithValues(A, v=1):
    return np.insert(A, 0, [v], axis=0)


def forwardPropagation(X, theta):
    activations = [None] * layerCounts
    activations[0] = X
    for i in range(1, layerCounts):
        # insert bias unit into evaluation
        a = prependWithValues(activations[i - 1])
        activations[i] = sigmoid(theta[i - 1] @ a)
    return activations


def predict(X):
    X = np.array(X)
    X = X.reshape((784, 1))
    activations = forwardPropagation(X, nn_theta)
    h = activations[-1]
    return (np.argmax(h, axis=0), h)