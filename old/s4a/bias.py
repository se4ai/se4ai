import random 
r=random.random
#random.seed(1)  <== important! somewhere, you must maintain seed control

# Train a distributions with samples. Draw from within
# that to recreate it. Draw from without to avoid it
class bin:
    def __init__(i):
        i.n = 0
        
class bins:
  def __init__(i,w=1)  : i.w,i.ns, i.d, i.ndx = w,0, {}, {}
  def train(  i,z,n=1,on=None): 
    i.put(z, n) 
    if on:          
      if z not in i.ndx : i.ndx[z] = set()
      i.ndx[z].add(on)
  def within(i)  : return i.get(lambda z:z/i.ns)
  def without(i) : return i.get(lambda z:(i.ns - z)/i.ns)
  def put(i,z,n) : i.all += n; 
    old = i.d.get(z, None)
    old = old or bin
    old.n += n
  def get(f):
    tmp = r()
    for k,v in i.d.items():
      tmp -= f(v)
      if tmp <= 0: return k

class ints:
  "Using 'bins',keep track of nums (rounded to a width i.w)"
  def __init__(i,w=1): i.bins = w, bins(w)
  def within(i)                 : return i.bins.within()  
  def without(i)                : return i.bins.without() 
  def train(  i, z, n=1,on=None): i.bins.train(  i.bins.w, n, on)

class floats:
  "Using 'bins',keep track of floats (rounded to a width i.w)"
  def __init__(i,w=0.12): i.w, i.bins = w, bins(w)
  def within(i)                 : return i.bins.within()  + r()*i.bins.w
  def without(i)                : return i.bins.without() + r()*i.bins.w
  def train(  i, z, n=1,on=None): i.bins.train(  z//i.w * i.bins.w, n, on)

class around:
  """Using 'nums', whenever you train on z, spread 
  some of that effect around the nearby region. XXXnot defined for ints?"""
  def __init__(i, w    = 0.12,
                  near = [-1.5, -0.5, 0, 0.5, 1.5],
                  fxs  = [   1,    2, 6,   2, 1  ]):
    i.nums = nums(w)
    i.todo = [(z, fx/sum(fxs)) for z,fx in zip(near,fxs)]
  def within(i)                 : return i.nums.within()
  def without(i)                : return i.nums.without()
  def train(  i, z, n=1,on=None): i.nearby(z, n, on, i.nums.train)
  def nearby(i,z,n,on, f)   : 
    for near, effect in i.todo: 
      f( z + i.nums.w*near, n*effect, on )

class norm(object):
  def __init__(i, lo=10**32, hi=-10**32): i.lo,i.hi = lo,hi
  def __call__(i,z):
    i.lo, i.hi = min(z,i.lo), max(z,i.hi)
    return (z - i.lo) / (i.hi - i.lo + 10**-32)

norm1=norm()
for _ in range(100):
  print(norm1(10*r()))

# add a support set. and an forget
# add a simulated annealler
# add a rule learner (greedy) 
# remember to add things at strength 0 if we like them (otherwise
#      we'll never see that thing)
# add ffts and doing within/without at each level


