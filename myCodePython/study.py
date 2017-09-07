print("hello")
import numpy as np
import matplotlib.pyplot as plt
import theano
import theano.tensor as T

foo=T.scalar('foo')
bar=foo**2
print(type(bar))
print(bar.type)
print(theano.pp(bar))

f=theano.function([foo],bar)#the first argument of theano.function define the input of function
print(f(5))

print(bar.eval({foo:3}))

def square(x):
	return x**2
bar=square(foo)
print(bar.eval({foo:3}))

#theano.tensor
A=T.matrix('A')
x=T.vector('x')
b=T.vector('b')
y=T.dot(A,x)+b# y=Ax+b
z=T.sum(A**2)
b_default=np.array([0,0],dtype=theano.config.floatX)
linear_mix=theano.function([A,x,theano.Param(b,default=b_default)],[y,z])
A_val=np.array([[1,2,3],[4,5,6]],dtype=theano.config.floatX)
x_val=np.array([1,2,3],dtype=theano.config.floatX)
b_val=np.array([4,5],dtype=theano.config.floatX)
print(linear_mix(A_val,x_val,b_val))
print(linear_mix(A_val,x_val))

print("A_val.shape:"+str(A_val.shape))
print("x_val.shape:"+str(x_val.shape))

one=np.array([1,2,3])
print(one)
print(one.shape)

#shared variable
shared_var=theano.shared(np.array([[1,2],[3,4]],dtype=theano.config.floatX))
print(shared_var.type())
shared_var.set_value(np.array([[4,3],[5,6]],dtype=theano.config.floatX))
print(shared_var.get_value())

shared_squared=shared_var**2
function1=theano.function([],shared_squared)
print(function1())

subtract=T.matrix('subtract')
function2=theano.function([subtract],shared_var,updates={shared_var:shared_var-subtract})
print("before update")
print(shared_var.get_value())
print("after update")
print(function2(np.array([[1,1],[1,1]],dtype=theano.config.floatX)))#shared_val doesn't change
print(shared_var.get_value())#shared_val changed
print("new output of function1")
print(function1())

#Gradients
bar_grad=T.grad(bar,foo)# bar=boo**2
print(bar_grad.eval({foo:10}))

y_j=theano.gradient.jacobian(y,x)
linear_mix_j=theano.function([A,x,b],y_j)
print(linear_mix_j(A_val,x_val,b_val))

print(theano.config.floatX)
print(theano.config.device)