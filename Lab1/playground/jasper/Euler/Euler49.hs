module Euler49 where

import Primes
import Data.List

-- Uses primes from Primes.hs
fourDigitPrimes :: [Integer]
fourDigitPrimes = [p | p <- (takeWhile (10000>) primes), p >= 1000] 


-- Generate prime triples with the 3330 difference
-- Primes larger than 3340 result cause the last prime of the triple to be larger than 10000
-- uses prime from Primes.hs
primeTriples :: [(Integer, Integer, Integer)]
primeTriples = [(a, b, c) | a <- takeWhile (3340>=) fourDigitPrimes, 
							let b = a+3330, 
							let c = b+3330, 
							(prime b) && (prime c)]


isPermutedTriple :: (Integer, Integer, Integer) -> Bool
isPermutedTriple (a,b,c) = (isPermutation a b) && (isPermutation a c)
	where
	isPermutation :: Integer -> Integer -> Bool
	isPermutation a b = (sort$show a) == (sort$show b)
	

permutedPrimeTriples :: [(Integer, Integer, Integer)]
permutedPrimeTriples = filter isPermutedTriple primeTriples

solution49 :: [(Integer, Integer, Integer)]
solution49 = permutedPrimeTriples
