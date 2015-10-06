module Assignment4 where

import Lecture6
import Control.Monad

composites :: [Integer]
composites = filter (not.isPrime) [2..]

testFermat :: Int -> [Integer] -> IO Integer
testFermat k (x:xs) = do
                        resultTest <- prime_tests_F k x
                        if resultTest then return x
                        else testFermat k xs