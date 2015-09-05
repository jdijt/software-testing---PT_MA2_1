{- 

Euler 10: Summation of Primes
Nikki van Ommeren
10017704
05 - 09 - 2015

-}

module Euler10 where


{- Source for the following 3 functions is:
   Haskell road to Logic, Math and Programming 
   by Kees Doets and Jan van Eijck-}

-- |Checks whether a number is a prime
prime :: Integer -> Bool
prime n | n < 1 = error "not a positive integer"
        | n == 1 = False
        | otherwise = ldp n == n

-- |Finds the least prime divider of an integer
ldp :: Integer -> Integer
ldp n = ldpf primes n

-- |Finds the least divider from an input list for an integer
ldpf :: [Integer] -> Integer -> Integer
ldpf (p:ps) n | rem n p == 0 = p
              | p^2 > n = n
              | otherwise = ldpf ps n

-- |Returns a list of primes below 2 million
primes :: [Integer]
primes = 2 : filter prime [3..2000000]

-- |Returns the sum of all primes below 2 million
sumprimes :: Integer
sumprimes = sum primes        