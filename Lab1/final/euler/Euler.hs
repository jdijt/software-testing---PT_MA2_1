module Euler where

import Primes
import Data.List

-- For a < b < c
-- We can conclude that a <= 333 and b <= 499
solution9 :: Integer
solution9 = head [a * b * c | a <- [1..333], b <- [a..499], let c = 1000 - a - b, a^2 + b^2 == c^2]


solution10 :: Integer
solution10 = sum (takeWhile (<2000000) primes)


-- Check for all primes up to 3339 if the other triplet members (+3330 and +6660)
-- are permutation of the prime and itself is a prime
-- excluding the solution 1487
solution49 :: Integer
solution49 = concatTriples solution' (solution' + 3330) (solution' + 6660) where
    solution' = head $ filter (\x -> prime x && isPrimeAndPermutation x (x + 3330) && isPrimeAndPermutation x (x + 6660)) $ ([1000..3339] \\ [1487])

concatTriples a b c = 100000000 * a + 10000 * b + c

isPrimeAndPermutation :: Integer -> Integer -> Bool
isPrimeAndPermutation x y = prime y && isPermutation x y where

isPermutation :: Integer -> Integer -> Bool
isPermutation x y = (sort . show) x == (sort . show) y
