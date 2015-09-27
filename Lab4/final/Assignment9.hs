module Assignment9 where


instance Show Expr where
    show = showExpr

instance Show Condition where
    show = showCond

instance Show Statement where
    show = showSt 0

-- Use Polish notation in print to ease parsing later on.
showExpr :: Expr -> String
showExpr (I i)         = show i
showExpr (V v)         = showVar v
showExpr (Add e1 e2)   = "+ " ++ show e1 ++ " " ++ show e2
showExpr (Subtr e1 e2) = "- " ++ show e1 ++ " " ++ show e2
showExpr (Mult e1 e2)  = "* " ++ show e1 ++ " " ++ show e2


showCond :: Condition -> String
showCond (Prp v)       = showVar v
showCond (Eq e1 e2)    = "== " ++ show e1 ++ " " ++ show e2
showCond (Lt e1 e2)    = "< " ++ show e1 ++ " " ++ show e2
showCond (Gt e1 e2)    = "> " ++ show e1 ++ " " ++ show e2
showCond (Ng c)        = "! " ++ show c
showCond (Cj xs)       = "*(" ++ showLst xs ++")"
showCond (Dj xs)       = "+(" ++ showLst xs ++")"
        

showSt :: Int -> Statement -> String
showSt i (Ass v e)      = indent i ++ ":= " ++ showVar v ++ " " ++ show e ++";" ++ newLine 
showSt i (Cond c s1 s2) = indent i ++ "IF "++ show c ++ " THEN" ++ newLine
                        ++ showSt (i + 2) s1
                        ++ indent i ++ "ELSE" ++ newLine
                        ++ showSt (i + 2) s2
                        ++ indent i ++ "FI" ++ newLine
showSt i (While c s)    = indent i ++ "WHILE " ++ show c ++ " DO" ++ newLine
                        ++ showSt(i+2) s
                        ++"DONE" ++ newLine
showSt i (Seq ss)        = concatMap (showSt i) ss


indent :: Int -> String
indent n  = replicate n ' ' 

newLine :: String
newLine = "\n"

showVar :: Var -> String
showVar [] = []
showVar s = (init.tail.show) s

--Taken from lecture 3
showLst,showRest :: [Condition] -> String
showLst [] = ""
showLst (c:cs) = show c ++ showRest cs
showRest [] = ""
showRest (c:cs) = ' ': show c ++ showRest cs



--------------------------------------
-- Imperative language implementation and types from lecture:

type Var = String
type Env = Var -> Integer


data Expr = I Integer | V Var 
          | Add Expr Expr 
          | Subtr Expr Expr 
          | Mult Expr Expr 
          deriving (Eq)

data Condition = Prp Var 
               | Eq Expr Expr 
               | Lt Expr Expr 
               | Gt Expr Expr 
               | Ng Condition 
               | Cj [Condition] 
               | Dj [Condition]
               deriving (Eq)

data Statement = Ass Var Expr
               | Cond Condition Statement Statement
               | Seq [Statement]
               | While Condition Statement
               deriving (Eq)

update :: Eq a => (a -> b) -> (a,b) -> a -> b
update f (x,y) z = if x == z then y else f z 

updates :: Eq a => (a -> b) -> [(a,b)] -> a -> b
updates = foldl update


infixl 1 $$

($$) :: a -> (a -> b) -> b
($$) = flip ($)


eval :: Env -> Expr -> Integer 
eval _ (I i) = i 
eval c (V name) = c name
eval c (Add e1 e2)   = eval c e1 + eval c e2
eval c (Subtr e1 e2) = eval c e1 - eval c e2
eval c (Mult e1 e2)  = eval c e1 * eval c e2

assign :: Var -> Expr -> Env -> Env 
assign var expr c = let value = eval c expr in update c (var,value)

initEnv :: Env 
initEnv = undefined

evalc :: Env -> Condition -> Bool
evalc env (Prp v)    = env v /= 0
evalc env (Eq e1 e2) = eval env e1 == eval env e2
evalc env (Lt e1 e2) = eval env e1 <  eval env e2
evalc env (Gt e1 e2) = eval env e1 >  eval env e2
evalc env (Ng c)     = not (evalc env c)
evalc env (Cj cs)    = all (evalc env) cs
evalc env (Dj cs)    = any (evalc env) cs

exec :: Env -> Statement -> Env 
exec env (Ass v e) = assign v e env
exec env (Cond c s1 s2) = 
    if evalc env c then exec env s1 
    else exec env s2 
exec env (Seq ss) = foldl exec env ss                    
exec env w@(While c s) = 
    if not (evalc env c) then env 
    else exec (exec env s) w
