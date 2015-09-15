module Assignment3 where

import Lecture3

toCNF :: Form -> Form
toCNF = liftCnj.nnf.arrowfree 

-- Precondition: Form is in NNF.
liftCnj :: Form -> Form

-- Turn children to cnf and fold disjunction into conjunction of disjunctions:
liftCnj (Dsj ps) = foldDsj $ map liftCnj ps 

-- Turn children to cnf and merge child conjuctions with current conjunction.
liftCnj (Cnj ps) = Cnj (mergeCnj $ map liftCnj ps)

-- Should be Prop x / Neg (Prop x)  (Precondition) i.e.: Leaf nodes, do nothing with them. 
liftCnj x = x  


-- Assumes Any found conjunction has no further conjunctions under it.
mergeCnj :: [Form] -> [Form]
mergeCnj [] = []
mergeCnj (Cnj x:xs ) = x ++ mergeCnj xs
mergeCnj (x:xs) = x : mergeCnj xs

mergeDsj :: Form -> Form -> Form
mergeDsj (Dsj xs) (Dsj ys) = Dsj (xs ++ ys)
mergeDsj (Dsj xs) y = Dsj (y : xs)
mergeDsj x (Dsj ys) = Dsj (x : ys)
mergeDsj x y = Dsj [x, y]


-- Precondition: [Form] comes from a Dsj (so: [a,b,c] means: a V b V c
foldDsj :: [Form] -> Form
foldDsj [] = Cnj []
foldDsj (z:zs) = foldl distributeDsj z zs 
    where
    distributeDsj :: Form -> Form -> Form
    distributeDsj (Cnj xs) (Cnj ys) = Cnj [ mergeDsj x y | x <- xs, y <- ys]
    distributeDsj (Cnj xs) y = Cnj (map (`mergeDsj` y) xs)
    distributeDsj x y = distributeDsj (Cnj [x]) y

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

