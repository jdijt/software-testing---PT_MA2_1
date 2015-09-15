module Assignment5 where

import Lecture3
import Assignment3

type Clause = [Int]
type Clauses = [Clause]

form2cls :: Form -> Clauses
form2cls = cnf2cls.toCNF

cnf2cls :: Form -> Clauses
cnf2cls (Cnj xs) = map dsj2cl xs
cnf2cls x = [dsj2cl x]

dsj2cl :: Form -> Clause
dsj2cl (Dsj x) = map lit2int x
dsj2cl x = [lit2int x]

lit2int :: Form -> Int
lit2int (Prop x) = x
lit2int (Neg (Prop x)) = x * (-1)
lit2int _ = error "Argument not a property nor a negation of cnf format"
