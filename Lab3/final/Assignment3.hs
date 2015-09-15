module Assignment3 where

import Forms

liftCnj :: Form -> Form
liftCnj (Dsj ps) = foldDsj qs where
    qs = map liftCnj ps
liftCnj x = x

foldDsj :: [Form] -> Form
foldDsj (Cnj x:y:ys) = foldDsj (distribute (Cnj x) y : ys)
foldDsj (x:y:ys) = foldDsj (Cnj [x] : y : ys)
foldDsj [x] = x
foldDsj _ = error "WHELR:AJFKL:"

distribute :: Form -> Form -> Form
distribute (Cnj xs) (Cnj ys) = Cnj [ Dsj [x,y] | x <- xs, y <- ys]
distribute (Cnj xs) y = Cnj (map (\q -> Dsj [q, y]) xs)
distribute _ _ = error "No CNJ"

testLiftCnj :: Bool
testLiftCnj = and [liftCnj (Prop 1) == Prop 1,
            liftCnj (Neg (Prop 1)) == Neg (Prop 1),
            liftCnj (Dsj [Prop 1, Prop 2]) == Cnj [Dsj [Prop 1, Prop 2]],
            liftCnj (Cnj [Prop 1, Prop 2]) == Cnj [Prop 1, Prop 2],
            liftCnj (Cnj [Dsj [Prop 1, Prop 2], Prop 3]) == Cnj [Dsj [Prop 1, Prop 2], Prop 3],
            liftCnj (Dsj [Cnj [Prop 1, Prop 2], Prop 3]) == Cnj [Dsj [Prop 1, Prop 3], Dsj [Prop 2, Prop 3]]]

nnf :: Form -> Form 
nnf (Prop x) = Prop x
nnf (Neg (Prop x)) = Neg (Prop x)
nnf (Neg (Neg f)) = nnf f
nnf (Cnj fs) = Cnj (map nnf fs)
nnf (Dsj fs) = Dsj (map nnf fs)
nnf (Neg (Cnj fs)) = Dsj (map (nnf.Neg) fs)
nnf (Neg (Dsj fs)) = Cnj (map (nnf.Neg) fs)

arrowfree :: Form -> Form 
arrowfree (Prop x) = Prop x 
arrowfree (Neg f) = Neg (arrowfree f)
arrowfree (Cnj fs) = Cnj (map arrowfree fs)
arrowfree (Dsj fs) = Dsj (map arrowfree fs)
arrowfree (Impl f1 f2) = 
  Dsj [Neg (arrowfree f1), arrowfree f2]
arrowfree (Equiv f1 f2) = 
  Dsj [Cnj [f1', f2'], Cnj [Neg f1', Neg f2']]
  where f1' = arrowfree f1
        f2' = arrowfree f2
