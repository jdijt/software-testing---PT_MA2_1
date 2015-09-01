module Euler49 where

import Primes
import Data.List

-- Primes larger than 3340 result cause the last prime of the triple to be larger than 10000
fourDigitPrimes :: [Integer]
fourDigitPrimes = [p | p <- (takeWhile ((3340)>) primes), p >= 1000] 


--Generate prime triples with the 3330 difference
primeTriples :: [(Integer, Integer, Integer)]
primeTriples = [(a, b, c) | a <- fourDigitPrimes, let b = a+3330, let c = b+3330, prime b, prime c]


--Check if two numbers are permutations of each other:
isPermutation :: Integer -> Integer -> Bool
isPermutation a b = (sort$toString a) == (sort$toString b)
	where
	toString :: Integer -> String
	toString i = show i

isPermutedTriple :: (Integer, Integer, Integer) -> Bool
isPermutedTriple (a,b,c) = (isPermutation a b) && (isPermutation a c)


permutedPrimeTriples :: [(Integer, Integer, Integer)]
permutedPrimeTriples = filter isPermutedTriple primeTriples
