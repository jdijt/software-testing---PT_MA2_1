module Forms where

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
pnames (Prop name) = [name]
pnames (Neg f)  = pnames f
pnames (Cnj fs) = concat (map pnames fs)
pnames (Dsj fs) = concat (map pnames fs)
pnames (Impl f1 f2)  = concat (map pnames [f1,f2])
pnames (Equiv f1 f2) = concat (map pnames [f1,f2])


-- | all possible valuations for lists of prop letters
genVals :: [Name] -> [Valuation]
genVals [] = [[]]
genVals (name:names) = 
	map ((name,True) :) (genVals names)
	++ map ((name,False):) (genVals names)

-- | generate all possible valuations for a formula
allVals :: Form -> [Valuation]
allVals = genVals . propNames

val2fct :: Valuation -> ValFct
val2fct = updates (\ _ -> undefined)

fct2val :: [Name] -> ValFct -> Valuation
fct2val domain f = map (\x -> (x,f x)) domain 

satisfiable :: Form -> Bool
satisfiable f = any (\ v -> evl v f) (allVals f)
