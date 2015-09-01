module EULER where

import GHC.Float
import Data.List

--Haskell road to logic prime implementation
ldp :: Integer -> Integer
ldp n = ldpf primes n

ldpf :: [Integer] -> Integer -> Integer
ldpf [] _     = 0
ldpf (p:ps) n | rem n p == 0 = p
              | (p^2) > n    = n
              | otherwise    = ldpf ps n

primes :: [Integer]
primes = 2 : filter prime [3..]

prime :: Integer -> Bool
prime n | n < 1     = error "not a positive integer"
        | n == 1    = False
        | otherwise = ldp n == n


-- 9. Special Pythagorean triplet
euler9 :: Integer
euler9 = toInteger $ product [float2Int a, float2Int b,float2Int  c]
    where (a, b, c) = head [(a, b, sqrt(a^2 + b^2) ) | a <- [1..500], b <- [1..500], a < b, (a + b + sqrt(a^2 + b^2) == 1000) ]

-- 10. Summation of primes
euler10 :: Integer
euler10 = sum (takeWhile (<2000000) primes)

-- 49. Prime permutations
fourDigitPrimes :: [Integer]
fourDigitPrimes = dropWhile (<1000) $ takeWhile (< 10000-2*3330) primes

fourDigitPrimeTriplets :: [(Integer,Integer,Integer)]
fourDigitPrimeTriplets = filter (\(x, y, z) -> prime y && prime z) $ map (\x -> (x, x+3330, x + 6660)) fourDigitPrimes

integerPermutation :: Integer -> Integer -> Bool
integerPermutation x y = (sort $ show x) == (sort $ show y)

findPrimePermutationTriplets :: [(Integer, Integer, Integer)]
findPrimePermutationTriplets = filter(\(x, y, z) -> integerPermutation x  y && integerPermutation x z) fourDigitPrimeTriplets

euler49 :: Integer
euler49 = last $ map (\(x, y, z) -> x * 100000000 + y * 10000 + z) findPrimePermutationTriplets
