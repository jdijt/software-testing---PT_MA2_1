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
