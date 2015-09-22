module Assignment8 where


fib :: Statement
fib = Seq [Ass "x" (I 0), Ass "y" (I 1), 
           While (Gt (V "n") (I 0))
             (Seq [Ass "z" (V "x"), 
                   Ass "x" (V "y"),
                   Ass "y" (Add (V "z") (V "y")), 
                   Ass "n" (Subtr (V "n") (I 1))])]


instance Show Expr where
    show (I i)         = show i
    show (V v)         = showVar v
    show (Add e1 e2)   = "(" ++ show e1 ++" + "++ show e2 ++")"
    show (Subtr e1 e2) = "(" ++ show e1 ++" - "++ show e2 ++")"
    show (Mult e1 e2)  = "(" ++ show e1 ++" * "++ show e2 ++")"

instance Show Condition where
    show (Prp v)       = showVar v
    show (Eq e1 e2)    = "(" ++ show e1 ++"=="++ show e2 ++")"
    show (Lt e1 e2)    = "(" ++ show e1 ++"<"++ show e2 ++")"
    show (Gt e1 e2)    = "(" ++ show e1 ++">"++ show e2 ++")"
    show (Ng c)        = "!("++ show c ++")"
    show (Cj xs)       = "*("++ showLst xs ++")"
    show (Dj xs)       = "+("++ showLst xs ++")"

showVar :: Var -> String
showVar = init.tail.show

--Taken from lecture 3
showLst,showRest :: [Condition] -> String
showLst [] = ""
showLst (c:cs) = show c ++ showRest cs
showRest [] = ""
showRest (c:cs) = ' ': show c ++ showRest cs

instance Show Statement where
    show = showSt 0 
        where
        showSt :: Int -> Statement -> String
        showSt i (Ass v e)      = indent i ++ showVar v ++ " := " ++ show e ++";" ++ newLine 
        showSt i (Cond c s1 s2) = indent i ++ "IF "++ show c ++ " THEN" ++ newLine
                                ++ showSt(i+2) s1
                                ++ indent i ++ "ELSE" ++ newLine
                                ++ showSt(i+2) s2
                                ++ indent i ++ "ENDIF" ++ newLine
        showSt i (While c s)    = indent i ++ "WHILE " ++ show c ++ " DO" ++ newLine
                                ++ showSt(i+2) s
                                ++"DONE" ++ newLine
        showSt i (Seq ss)        = concatMap (showSt i) ss

    
        indent :: Int -> String
        indent n  = replicate n ' ' 
    
        newLine :: String
        newLine = "\n"

-------------------------------
------------------------------
-- Imperative language implementation from Lecture.

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
