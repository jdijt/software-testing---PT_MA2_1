module Assignment3 where

import Forms

liftCnj :: Form -> Form
liftCnj (Dsj ps) = foldDsj $ map liftCnj ps 
liftCnj (Cnj ps) = Cnj (mergeCnj $ map liftCnj ps))
liftCnj x = x

-- Assumes Any found conjunction has no further conjunctions under it.
mergeCnj :: [Form] -> [Form]
mergeCnj [] = []
mergeCnj (Cnj x:xs ) = x ++ mergeCnj xs
mergeCnj (x:xs) = x : mergeCnj xs

-- Assumes Any found disjunction has no further disjuntions under it.
mergeDsj :: [Form] -> [Form]
mergeDsj [] = []
mergeDsj (Dsj x:xs ) = x ++ mergeDsj xs
mergeDsj (x:xs) = x : mergeDsj xs


foldDsj :: [Form] -> Form
foldDsj (x:xs) = foldl distribute x xs
foldDsj [] = Cnj []

distribute :: Form -> Form -> Form
distribute (Cnj xs) (Cnj ys) = Cnj [ Dsj (mergeDsj [x,y]) | x <- xs, y <- ys]
distribute (Cnj xs) y = Cnj (map (\q -> Dsj (mergeDsj [q,y])) xs)
distribute x y = distribute (Cnj [x]) y

testLiftCnj :: Bool
testLiftCnj = and [liftCnj (Prop 1) == Prop 1,
            liftCnj (Neg (Prop 1)) == Neg (Prop 1),
            liftCnj (Cnj [Prop 1, Prop 2]) == Cnj [Prop 1, Prop 2],
            liftCnj (Dsj [Prop 1, Prop 2]) == Cnj [Dsj [Prop 1, Prop 2]],
            liftCnj (Cnj [Cnj [Prop 1], Cnj [Prop 1] ]) == Cnj [Prop 1, Prop 1],
            liftCnj (Dsj [Dsj [Prop 1], Dsj [Prop 1] ]) == Cnj [Dsj [Prop 1, Prop 1]],
            liftCnj (Cnj [Dsj [Prop 1, Prop 2], Prop 3]) == Cnj [Dsj [Prop 1, Prop 2], Prop 3],
            liftCnj (Cnj [Cnj [Prop 1], Dsj [Prop 2, Prop 3] ]) == Cnj [Prop 1, Dsj [Prop 2, Prop 3]],
            liftCnj (Dsj [Cnj [Prop 1, Prop 2], Prop 3]) == Cnj [Dsj [Prop 1, Prop 3], Dsj [Prop 2, Prop 3]],
            liftCnj (Dsj [Cnj [Prop 1, Prop 2], Cnj [Prop 3, Prop 4]]) ==
              Cnj [Dsj [Prop 1, Prop 3], Dsj [Prop 1, Prop 4], Dsj [Prop 2, Prop 3], Dsj [Prop 2, Prop 4]],
            liftCnj (Cnj [Cnj [Prop 1], Dsj [Prop 2, Prop 3] ]) == Cnj [Prop 1, Dsj [Prop 2, Prop 3]],
            liftCnj (Cnj [Dsj [Cnj [Dsj [Cnj [Prop 1]]]]]) == Cnj [Prop 1]]

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
arrowfree (Impl f1 f2) = Dsj [Neg (arrowfree f1), arrowfree f2]
arrowfree (Equiv f1 f2) = Dsj [Cnj [f1', f2'], Cnj [Neg f1', Neg f2']]
  where f1' = arrowfree f1
        f2' = arrowfree f2
