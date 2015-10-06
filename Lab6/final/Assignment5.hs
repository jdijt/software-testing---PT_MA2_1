module Assignment5 where

import Lecture6

carmichael :: [Integer]
carmichael = [(6*k+1)*(12*k+1)*(18*k+1) | k <- [2..], isPrime (6*k+1), isPrime (12*k+1), isPrime (18*k+1)]



printFermatResults :: Int -> Integer -> [Integer] -> IO [(Integer, Bool)]
printFermatResults _ 0 _      = return []
printFermatResults k n (c:cs) = do
    r <- prime_tests_F k c
    rs <- printFermatResults k (n-1) cs
    return ((c,r) : rs) 
