module Forms where

import Data.List
-- Taken from lecture 3, a form type with associated functions.

type Name = Int
type ValFct = Name -> Bool
type Valuation = [(Name,Bool)]

data Form = Prop Name
          | Neg  Form
          | Cnj [Form]
          | Dsj [Form]
          | Impl Form Form
          | Equiv Form Form
          deriving Eq

instance Show Form where
	show (Prop x)      = show x
	show (Neg f)       = '-' : show f
	show (Cnj fs)      = "*(" ++ showLst fs ++ ")"
	show (Dsj fs)      = "+(" ++ showLst fs ++ ")"
	show (Impl f1 f2)  = "(" ++ show f1 ++ "==>"
	                     ++ show f2 ++ ")"
	show (Equiv f1 f2) = "(" ++ show f1 ++ "<=>"
	                     ++ show f2 ++ ")"

showLst,showRest :: [Form] -> String
showLst [] = ""
showLst (f:fs) = show f ++ showRest fs
showRest [] = ""
showRest (f:fs) = ' ': show f ++ showRest fs

propNames :: Form -> [Name]
propNames = sort.nub.pnames where
  pnames :: Form -> [Name]
  pnames (Prop name) = [name]
  pnames (Neg f)  = pnames f
  pnames (Cnj fs) = concatMap pnames fs
  pnames (Dsj fs) = concatMap pnames fs
  pnames (Impl f1 f2)  = concatMap pnames [f1,f2]
  pnames (Equiv f1 f2) = concatMap pnames [f1,f2]


-- | all possible valuations for lists of prop letters
genVals :: [Name] -> [Valuation]
genVals [] = [[]]
genVals (name:names) =
	map ((name,True) :) (genVals names)
	++ map ((name,False):) (genVals names)

update :: Eq a => (a -> b) -> (a,b) -> a -> b
update f (x,y) z = if x == z then y else f z

updates :: Eq a => (a -> b) -> [(a,b)] -> a -> b
updates = foldl update


-- | generate all possible valuations for a formula
allVals :: Form -> [Valuation]
allVals = genVals . propNames

val2fct :: Valuation -> ValFct
val2fct = updates (const undefined)

fct2val :: [Name] -> ValFct -> Valuation
fct2val domain f = map (\x -> (x,f x)) domain

evl :: Valuation -> Form -> Bool
evl [] (Prop c)    = error ("no info: " ++ show c)
evl ((i,b):xs) (Prop c) | c == i    = b
                        | otherwise = evl xs (Prop c)
evl xs (Neg f)  = not (evl xs f)
evl xs (Cnj fs) = all (evl xs) fs
evl xs (Dsj fs) = any (evl xs) fs
evl xs (Impl f1 f2) =
    not (evl xs f1) || evl xs f2
evl xs (Equiv f1 f2) = evl xs f1 == evl xs f2

satisfiable :: Form -> Bool
satisfiable f = any (`evl` f) (allVals f)
