module Assignment5 where

import Forms

type Clause = [Int]
type Clauses = [Clause]

cnf2cls :: Form -> Clauses
cnf2cls (Cnj xs) = map (\(Dsj ys) -> map lit2int ys ) xs
cnf2cls (Dsj xs) = [map lit2int xs]
cnf2cls x = [[lit2int x]]

lit2int :: Form -> Int
lit2int (Prop x) = x
lit2int (Neg (Prop x)) = x * (-1)
lit2int _ = error "Argument not a property nor a negation of cnf format"
