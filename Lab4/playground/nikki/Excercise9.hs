module Exercise9 where

import Lecture4

instance Show Statement where 
  show (Ass v e)       =  v ++ " := " ++ showExpr e
  show (Cond c s t)    = "\n" ++ "if " ++ showCond c ++ " then " ++ show s ++ "\n" 
  	                     ++ " else " ++ show t
  show (Seq [])        = [] 
  show (Seq [x])       = show x 
  show (Seq (x:xs))    = show x ++ "; " ++ show (Seq xs)
  show (While c s)     = "\n" ++ "while " ++ showCond c ++ " do { " ++ show s ++ " }" 

showExpr :: Expr -> String
showExpr (I i) = show i
showExpr (V v) = v
showExpr (Add e f) = "(" ++ (showExpr e) ++ " + " ++ (showExpr f) ++ ")"
showExpr (Subtr e f) = "(" ++ (showExpr e) ++ " - " ++ (showExpr f) ++ ")"
showExpr (Mult e f) = "(" ++ (showExpr e) ++ " * " ++ (showExpr f) ++ ")"

showCond :: Condition -> String 
showCond (Prp v)  = v
showCond (Eq e f) = showExpr e ++ " == " ++ showExpr f
showCond (Lt e f) = showExpr e ++ " <= " ++ showExpr f
showCond (Gt e f) = showExpr e ++ " => " ++ showExpr f
showCond (Ng n)   = "¬" ++ showCond n
showCond (Cj c)   = "(" ++ showLst 1 c ++ ")"
showCond (Dj d)   = "(" ++ showLst 2 d ++ ")"

showLst :: Int -> [Condition] -> String
showLst _ [] = []
showLst _ [x] = showCond x 
showLst n (x:xs) = showCond x ++ 
                   if n == 1 then " ^ " ++ showLst 1 xs
                   else " v " ++ showLst 2 xs

fib :: Statement
fib = Seq [Ass "x" (I 0), Ass "y" (I 1), 
           While (Gt (V "n") (I 0))
             (Seq [Ass "z" (V "x"), 
                   Ass "x" (V "y"),
                   Ass "y" (Add (V "z") (V "y")), 
                   Ass "n" (Subtr (V "n") (I 1))])]

testCondition :: Statement
testCondition = Cond (Prp "x") (Ass "y" (I 1)) (Ass "z" (I 3)) 



