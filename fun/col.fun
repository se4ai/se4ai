#!/usr/bin/env ./fun
# vim: nospell filetype=awk ts=2 sw=2 sts=2  et :

@include "funny"

BEGIN {IGNORE="\\?"}


------------------------------------------------------------
function Col(i,c,v) { 
  Object(i)   
  i.n=0
  i.col=c
  i.txt=v 
} 
function Col1(i,v,   add) {
  if (v ~ IGNORE) return v
  add = i.add
  return @add(i,v)
} 
------------------------------------------------------------
function Sym(i,c,v) { 
  Col(i,c,v)
  i.mode=""
  i.most=0
  has(i,"cnt") 
  i.add ="Sym1" 
}
function Sym1(i,v,  tmp) {
  i.n++
  tmp = ++i.cnt[v]
  if (tmp > i.most) {
    i.most = tmp
    i.mode = v }
  return v
}
------------------------------------------------------------
## Num
function Num(i,c,v) {
  Col(i,c,v)
  i.n  = i.mu = i.m2 = i.sd = 0
  i.lo = 10^32 
  i.hi = -1*i.lo
  i.add ="Num1" 
}
function Num1(i,v,    d) {
  v += 0
  i.n++
  i.lo  = v < i.lo ? v : i.lo
  i.hi  = v > i.hi ? v : i.hi
  d     = v - i.mu
  i.mu += d/i.n
  i.m2 += d*(v - i.mu)
  i.sd  = i.n < 2 ? 0 : (i.m2/(i.n - 1))^0.5
  return v
}
function NumLess(i,v, d) {
  if (i.n < 2) return v
  i.n  -= 1
  d     = v - i.mu
  i.mu -= d/i.n
  i.m2 -= d*(v - i.mu)
  i.sd  = i.n < 2 ? 0 : (i.m2/(i.n - 1))^0.5
  return v
}
function NumNorm(i,x) {
  return (x - i.lo) / (i.hi - i.lo + 10^-32)
}
