"""
This example learns to classify hand-written digits from the
[MNIST](http://yann.lecun.com/exdb/mnist) dataset.  There are 60000
training and 10000 test examples. Each input x consists of 784 pixels
representing a 28x28 image.  The pixel values are normalized to
[0,1]. Each output y is converted to a ten-dimensional one-hot vector
(a vector that has a single non-zero component) indicating the correct
class (0-9) for a given image.  10 is used to represent 0.
You can run the demo using `julia mnist.jl` on the command line or
`julia> include(KnetLayers.dir("examples/mnist.jl"))` at the Julia prompt.
"""

using Knet, KnetLayers
import Knet: Data
#Data
include(Knet.dir("data","mnist.jl"))
dtrn,dtst = mnistdata(xsize=(784,:)); # dtrn and dtst = [ (x1,y1), (x2,y2), ... ] where xi,yi are

#Model
(m::MLP)(x,y) = nll(m(x),y)
(m::MLP)(d::Data) = mean(m(x,y) for (x,y) in d)
HIDDEN_SIZES = [100,50]
model = MLP(784,HIDDEN_SIZES...,10)

#Train
EPOCH=10
progress!(sgd(model,repeat(dtrn,EPOCH)))

#Test
@show 100accuracy(model, dtst)
