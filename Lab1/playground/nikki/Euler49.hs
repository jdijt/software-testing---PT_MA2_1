{- 

Euler 49: Prime Permutations
Nikki van Ommeren
10017704
05 - 09 - 2015

-}

module Euler49 where

import Data.List

-- Source: Haskell road to Logic, Math and Programming 
--         by Kees Doets and Jan van Eijck
sieve :: [Integer] -> [Integer]
sieve (0 : xs) = sieve xs
sieve (n : xs) = n : sieve (mark xs 1 n)
               where mark :: [Integer] -> Integer -> Integer -> [Integer]
                     mark (y:ys) k m | k == m = 0 : (mark ys 1 m)
                                     | otherwise = y : (mark ys (k+1) m)


-- |Returns a list of primes below 2 million
primes :: [Integer]
primes = 2 : filter prime [3..]

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

-- |Returns a list with all prime numbers with four digits
primes4 :: [Integer]
primes4 = sieve [2..9999]

-- |Converts integer to a list of integers in reverse order
int2list :: Integer -> [Integer]
int2list 0 = []
int2list x = x `mod` 10:int2list (x `div` 10)

-- |Converts a list of integers to an integer in reverse order
list2int :: [Integer] -> Integer
list2int [] = 0
list2int (x:xs) = x + 10 * list2int xs

-- |Gives all permutations of an int
permInt :: Integer -> [Integer]
permInt x = nub (map list2int (permutations (int2list x)))

findPrimes :: [(Integer, Integer, Integer)]
findPrimes = [(x,y,z) | x <- primes4, y <- permInt4 x, z <- permInt4 x, y - x == z - y, y /= x, z /= x, prime y, prime z]
             where permInt4 :: Integer -> [Integer]
                   permInt4 x = filter (> 999) (permInt x)

concatNumber :: Integer
concatNumber = head [ x*100000000 + y*10000 + z | (x,y,z) <- findPrimes, x /= 1487]

        