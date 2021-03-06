#!/usr/bin/env ./fun
# vim: nospell filetype=awk ts=2 sw=2 sts=2  et :
#--------- --------- --------- --------- --------- ---------

@include "funny"
@include "col"
@include "the"

BEGIN  {
  SKIPCOL = "\\?"
  NUMCOL  = "[<>\\$]"
  GOALCOL = "[<>!]"
  LESS    = "<"
}
#------------------------------------------------------------
function Row(i,t,lst,     c) {
  Object(i)
  has(i,"cells")
  i.dom = 0
  for(c in t.cols) 
    i.cells[c] = Col1(t.cols[c],  lst[c]) 
}
function RowDoms(i,all,t,  j) {
  i.dom = 0
  for(j=1; j<=THE.row.doms; j++)
    i.dom += RowDom(i, all[any(all)], t) / THE.row.doms
}
function RowDom(i,j,t,   a,b,c,s1,s2,n) {
  n = length(t.my.w)
  for(c in t.my.w) {
    a   = NumNorm( t.cols[c], i.cells[c] )
    b   = NumNorm( t.cols[c], j.cells[c] )
    s1 -= 10^( t.my.w[c] * (a-b)/n )
    s2 -= 10^( t.my.w[c] * (b-a)/n )
  }
  return s1/n < s2/n
}

  
#------------------------------------------------------------
function Tbl(i) { 
  Object(i)
  has(i,"my")
  has(i,"cols")
  has(i,"rows") 
}
function Tbl1(i,r,lst,    c) {
  if (r==1)  {
    for(c in lst)
      if (lst[c] !~ SKIPCOL) 
        TblCols(i, c, lst[c])
  } else  
    has2(i.rows,r-1,"Row",i,lst)  
}
function TblCols(i,c,v) {
  if (v ~ CLASSCOL) i.my.class = c
  v ~ NUMCOL  ? i.my.nums[c] : i.my.syms[c]
  v ~ GOALCOL ? i.my.goals[c]: i.my.xs[c]
  if (v ~ />/) i.my.w[c] =  1
  if (v ~ /</) i.my.w[c] = -1
  has2(i.cols,c,
       v ~NUMCOL ? "Num" : "Sym",
       c,v) 
}

