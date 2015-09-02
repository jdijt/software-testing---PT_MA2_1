module Euler.Problem49 where

import Data.List
import Euler.Primes

solution :: Integer
solution = solution' * 100000000 + (solution' + 3330) * 10000 + (solution' + 6660) where
    solution' = head $ filter (\x -> prime x && isPrimeAndPermutation x (x + 3330) && isPrimeAndPermutation x (x + 6660)) $ ([1000..3339] \\ [1487])

isPrimeAndPermutation :: Integer -> Integer -> Bool
isPrimeAndPermutation x y = prime y && isPermutation x y where

isPermutation :: Integer -> Integer -> Bool
isPermutation x y = (sort . show) x == (sort . show) y
