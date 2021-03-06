module Assignment3 where

import Forms

----- Code from the lecture:
arrowfree :: Form -> Form 
arrowfree (Prop x) = Prop x 
arrowfree (Neg f)  = Neg (arrowfree f)
arrowfree (Cnj fs) = Cnj (map arrowfree fs)
arrowfree (Dsj fs) = Dsj (map arrowfree fs)
arrowfree (Impl f1 f2) = Dsj [Neg (arrowfree f1), arrowfree f2]
arrowfree (Equiv f1 f2) = Dsj [Cnj [f1', f2'], Cnj [Neg f1', Neg f2']]
    where 
        f1' = arrowfree f1
        f2' = arrowfree f2

nnf :: Form -> Form 
nnf (Prop x) = Prop x
nnf (Neg (Prop x)) = Neg (Prop x)
nnf (Neg (Neg f)) = nnf f
nnf (Cnj fs) = Cnj (map nnf fs)
nnf (Dsj fs) = Dsj (map nnf fs)
nnf (Neg (Cnj fs)) = Dsj (map (nnf.Neg) fs)
nnf (Neg (Dsj fs)) = Cnj (map (nnf.Neg) fs)
nnf _ = error "Invalid input."


toCNF :: Form -> Form
toCNF (Prop x) = Prop x
toCNF (Neg p) = Neg(toCNF p)
toCNF (Cnj fs) = Cnj (map toCNF fs)
toCNF (Dsj fs) = foldDsj (map toCNF fs)
	| 

	where
	cnfTree :: [Form]
	cnfTree = map toCNF fs

	foldDsj :: [Form] -> Form
	foldDsj (Cnj x:y:ys) = foldDsj (distribute (Cnj x) y):ys
	foldDsj (x:y:ys) = foldDsj (Cnj [x] : y : ys)
	foldDsj [x] = x
	foldDsj _ = undefined

	distribute :: Form -> Form -> Form
	distribute (Cnj xs) (Cnj ys) = Cnj [ Dsj [x,y] | x <- xs, y <- ys]
	distribute (Cnj xs) y = Cnj [ Dsj [x,y] | x <- xs]
	distribute _ _ = undefined
