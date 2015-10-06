module Assignment4

where

import Lecture6
import Control.Monad

composites :: [Integer]
composites = filter (not.isPrime) [4..]

minFermCheck k (x:xs) = do
                         print x
                         r <- prime_tests_F k x
                         if r
                            then return (x)
                         else
                            minFermCheck k xs