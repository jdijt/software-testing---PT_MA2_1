module Statement where

type Var = String
type Env = Var -> Integer

data Expr = I Integer | V Var
         | Add Expr Expr
         | Subtr Expr Expr
         | Mult Expr Expr
         deriving (Eq,Show)
data Condition = Prp Var
              | Eq Expr Expr
              | Lt Expr Expr
              | Gt Expr Expr
              | Ng Condition
              | Cj [Condition]
              | Dj [Condition]
              deriving (Eq,Show)

showCondition :: Condition -> String
showCondition (Prp p) = p
showCondition (Eq x y) = '(' : showExpr x ++ " = " ++ showExpr y ++ ")"
showCondition (Lt x y) = '(' : showExpr x ++ " = " ++ showExpr y ++ ")"
showCondition (Gt x y) = '(' : showExpr x ++ " = " ++ showExpr y ++ ")"
showCondition (Ng c) = '!' : showCondition c
showCondition (Cj cs) = foldl (\b a -> b ++ " && " ++ a ) "" (map showCondition cs)
showCondition (Dj cs) = foldl (\b a -> b ++ " || " ++ a ) "" (map showCondition cs)


data Statement = Ass Var Expr
  | Cond Condition Statement Statement
  | Seq [Statement]
  | While Condition Statement
  deriving (Eq)


instance Show Statement where
    showsPrec _ statement string = showStatement 0 statement

showStatement :: Int -> Statement -> String
showStatement indent (Seq xs) = concatMap (showStatement indent) xs
showStatement indent (Ass v e) = toLine indent (v ++ " := " ++ showExpr e ++ ";")
showStatement indent (While c s) =
      toLine indent ("while " ++ showCondition c ++ " do") ++
      showStatement (indent + 2) s ++
      toLine indent "end"
showStatement indent (Cond c s1 s2) =
      toLine indent ("if " ++ showCondition c ++ " then") ++
      showStatement (indent + 2) s1 ++
      toLine indent "else" ++
      showStatement (indent + 2) s2 ++
      toLine indent "end"

toLine :: Int -> String -> String
toLine 0 s = s ++ "\n"
toLine x s = ' ' : toLine (x-1) s

showExpr :: Expr -> String
showExpr (V v) = v
showExpr (I i) = show i
showExpr (Add a b) = '(' : showExpr a ++ ('+' : showExpr b ++ ")")
showExpr (Subtr a b) = '(' : showExpr a ++ ('-' : showExpr b ++ ")")
showExpr (Mult a b) = '(' : showExpr a ++ ('*' : showExpr b ++ ")")

update :: Eq a => (a -> b) -> (a,b) -> a -> b
update f (x,y) z = if x == z then y else f z

eval :: Env -> Expr -> Integer
eval _ (I i) = i
eval c (V name) = c name
eval c (Add e1 e2)   = eval c e1 + eval c e2
eval c (Subtr e1 e2) = eval c e1 - eval c e2
eval c (Mult e1 e2)  = eval c e1 * eval c e2

assign :: Var -> Expr -> Env -> Env
assign var expr c = let
  value = eval c expr
  in
  update c (var,value)

evalc :: Env -> Condition -> Bool
evalc env (Prp v)    = env v /= 0
evalc env (Eq e1 e2) = eval env e1 == eval env e2
evalc env (Lt e1 e2) = eval env e1 <  eval env e2
evalc env (Gt e1 e2) = eval env e1 >  eval env e2
evalc env (Ng c) = not (evalc env c)
evalc env (Cj cs) = all (evalc env) cs
evalc env (Dj cs) = any (evalc env) cs

exec :: Env -> Statement -> Env
exec env (Ass v e) = assign v e env
exec env (Cond c s1 s2) =
  if evalc env c then exec env s1 else exec env s2
exec env (Seq ss) = foldl exec env ss
exec env w@(While c s) =
  if not (evalc env c) then env
    else exec (exec env s) w


state :: Statement
state = Seq [Ass "x" (I 0), Ass "y" (I 1), While (Gt (V "n") (I 0)) (Seq [Ass "z" (V "x"), Ass "x" (V "y"), Ass "y" (Add (V "z") (V "y")), Ass "n" (Subtr (V "n") (I 1))])]
state1 = Seq [Ass "x" (I 0), Ass "y" (I 1), While (Gt (V "n") (I 0)) (Seq [Ass "z" (V "x")])]
