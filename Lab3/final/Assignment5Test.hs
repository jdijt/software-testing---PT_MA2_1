module Assignment5Test where

import Lecture3
import Assignment5
import Test.QuickCheck

--instance Arbitrary Name where
--    arbitrary = elements [1,2,3,4,5,6,7,8]

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
            size <- elements [1..5]
            lits <- vectorOf size literal
            return (Dsj lits)

        literal :: Gen Form
        literal = do
                x <- elements [1..20]
                oneof [
                    return (Prop x),
                    return (Neg (Prop x))]
