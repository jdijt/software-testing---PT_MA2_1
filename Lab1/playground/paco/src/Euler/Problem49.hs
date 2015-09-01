module Euler.Problem49 where

import Data.List
import Euler.Primes

solution :: (Integer, Integer, Integer)
solution = (solution', solution' + 3330, solution' + 6660) where
    solution' = head $ filter (\x -> prime x && isPrimeAndPermutationOf x (x + 3330) && isPrimeAndPermutationOf x (x + 6660)) ([1000..3339] \\ [1487])

isPrimeAndPermutationOf x y = prime y && toSortedArray x == toSortedArray y where
    toSortedArray :: Integer -> [Integer]
    toSortedArray x = sort $ numToArray x

numToArray :: Integer -> [Integer]
numToArray x | x <= 0 = []
             | otherwise = (numToArray (div x 10)) ++ [(mod x 10)]
