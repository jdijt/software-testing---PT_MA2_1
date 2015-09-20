module Assignment5Test where

import Lecture3
import Assignment5
import Test.QuickCheck

-- Generates arbitrary Form instances in CNF.
instance Arbitrary Form where
    arbitrary = frequency [(1,literal), (1,dsj), (8,cnj)]
        where
        cnj :: Gen Form
        cnj = do
            size <- elements [1..10]
            dsjs <- vectorOf size ( frequency [ (1,literal), (3,dsj)])
            return (Cnj dsjs)

        dsj :: Gen Form
        dsj = do
            size <- elements [1..10]
            lits <- vectorOf size literal
            return (Dsj lits)

        literal :: Gen Form
        literal = do
                x <- elements [1..10]
                oneof [
                    return (Prop x),
                    return (Neg (Prop x))]


-- Relations between input and output to Test for:
prop_clausesLength :: Form -> Clauses -> Bool
prop_clausesLength (Prop _) cs = length cs == 1
prop_clausesLength (Neg _) cs = length cs == 1
prop_clausesLength (Dsj _) cs = length cs == 1
prop_clausesLength (Cnj ps) cs = length cs == length ps


prop_clauseLength :: Form -> Clauses -> Bool
prop_clauseLength (Prop _) (c:_) = length c == 1
prop_clauseLength (Neg _) (c:_) = length c == 1
prop_clauseLength (Dsj xs) (c:_) = length c == length xs
prop_clauseLength (Cnj []) [] = True
prop_clauseLength _ [] = False
prop_clauseLength (Cnj []) _ = False
-- Here we implicitly verify the that the order of clauses is equal to the order of the conjuncts in the input Form
prop_clauseLength (Cnj (x:xs)) (c:cs) = prop_clauseLength x [c] && prop_clauseLength (Cnj xs) cs


prop_nameSumEqual :: Form -> Clauses -> Bool
prop_nameSumEqual f cs = sumFormNames f == sumClauseAtoms cs
    where
    sumFormNames :: Form -> Int
    sumFormNames (Prop x) = x
    sumFormNames (Neg x) = (-1) * sumFormNames x
    sumFormNames (Dsj xs) = sum $ map sumFormNames xs
    sumFormNames (Cnj xs) = sum $ map sumFormNames xs

    sumClauseAtoms :: Clauses -> Int
    sumClauseAtoms cls = sum $ map sum cls



test_cnf2cls :: Form -> Bool
test_cnf2cls x = checkAllProperties x (cnf2cls x)
    where
    checkAllProperties :: Form -> Clauses -> Bool
    checkAllProperties f cs = prop_clausesLength f cs
                            && prop_clauseLength f cs
                            && prop_nameSumEqual f cs
