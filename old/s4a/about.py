# /* vim: set ts=2 sts=2 sw=2 et : */
#--------- --------- --------- --------- --------- ---------

def about(): return dict(
  _describe="""
s4a: SE/AI crossover tools
(C) 2019, timm@ieee.org UNLICENSE
This is free and unencumbered software released into the public domain.
""",
  _epilog="""
"Give me the fruitful error any time, full of seeds, bursting with
its own corrections. You can keep your sterile truth for yourself."
-- Vilfredo Pareto
"""
  # sway
  ,sep=     ("mark for cell seperator"           ,",")
  ,ignore=  ("mark for data to ignore "          ,"?")
  ,less  =  ("mark for goal to minimize"         ,"<")
  ,more  =  ("mark for goal to maximize"         ,">")
  ,klass=   ("mark for class character"          ,"!")
  ,tests =  ("run unit tests"                    ,False)
  ,tiles =  ("tiles display width"               ,40) 
  ,cliff=   ("small effect size (Cliff's dela)"  ,[0.147, 0.33, 0.474])
  ,samples= ("keep at most, say, 64 samples"     ,[64,32,128,256,128,512,1024])
  ,bins=    ("y-axis bins"                       ,[5,2,3,4,6,7,8,9,10])
  ,era=     ("era size"                          ,10)
  ,round=   ("in pretty print, round numbers"    ,3)
  ,seed=    ("random number seed"                ,61409389)
  ,repeats= ("repeats"                           ,[5,10])
  ,naways=  ("n-ways"                            ,[3,5,10])
  ,train=   ("training data (csv format)"        ,"train.csv")
  ,test=    ("testing data (csv format)"         ,"test.csv")
  ,verbose= ("verbose print"                     ,True)
  # --------------------------------------------------------------------
  # System
  ,run=     ("Run some test function, then quit" ,"")
  )

