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


mergeCnj :: Form -> Form
mergeCnj (Cnj ((Cnj f):fs)) = undefined 
mergeCnj _ = error "Invalid input: Conjunction expected."


liftCnj :: Form -> Form
liftCnj (Prop p) = Prop p
liftCnj (Neg p) = Neg p

