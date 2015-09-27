module Exercise9 where

import Lecture4

import Data.Char 

instance Show Statement where 
  show (Ass v e)     =  v ++ " := " ++ show e 
  show (Cond c s t)  = "if " ++ show c ++ " then " ++ show s ++ "\n" ++ " else " ++ show t ++ "\n"
  show (Seq [])      = [] 
  show (Seq [x])     = show x 
  show (Seq (x:xs))  = show x ++ "; " ++ show (Seq xs)
  show (While c s)   = "while " ++ show c ++ " do { " ++ show s ++ " }" ++ "\n" 

instance Show Expr where
  show (I i)       = show i
  show (V v)       = v
  show (Add e f)   = "(" ++ show e ++ " + " ++ show f ++ ")"
  show (Subtr e f) = "(" ++ show e ++ " - " ++ show f ++ ")"
  show (Mult e f)  = "(" ++ show e ++ " * " ++ show f ++ ")"

instance Show Condition where 
  show (Prp v)  = v
  show (Eq e f) = "(" ++ show e ++ " == " ++ show f ++ ")"
  show (Lt e f) = "(" ++ show e ++ " <= " ++ show f ++ ")"
  show (Gt e f) = "(" ++ show e ++ " => " ++ show f ++ ")"
  show (Ng n)   = "-" ++ show n
  show (Cj c)   = "*(" ++ showLst c ++ ")"
  show (Dj d)   = "+(" ++ showLst d ++ ")"

showLst :: [Condition] -> String
showLst [] = []
showLst [x] = show x 
showLst (x:xs) = show x ++ " " ++ showLst xs

fib :: Statement
fib = Seq [Ass "x" (I 0), Ass "y" (I 1), 
           While (Gt (V "n") (I 0))
             (Seq [Ass "z" (V "x"), 
                   Ass "x" (V "y"),
                   Ass "y" (Add (V "z") (V "y")), 
                   Ass "n" (Subtr (V "n") (I 1))])]

testCondition :: Statement
testCondition = Cond (Prp "x") (Ass "y" (I 1)) (Ass "z" (I 3)) 



