module Euler where
import Data.List;

ldp :: Integer -> Integer
ldp = ldpf primes

ldpf :: [Integer] -> Integer -> Integer
ldpf [] _     = 0
ldpf (p:ps) n | rem n p == 0 = p
              | (p^2) > n    = n
              | otherwise    = ldpf ps n

factors :: Integer -> [Integer]
factors n | n < 1     = error "argument not positive"
          | n == 1    = []
          | otherwise = p : factors (div n p) where p = ldp n

prime :: Integer -> Bool
prime n | n < 1     = error "not a positive integer"
        | n == 1    = False
        | otherwise = ldp n == n

primes :: [Integer]
primes = 2 : filter prime [3..]

euler135 :: Integer
euler135 =  toInteger $ length (filter (== 10) $ map (length . primeCenterCandidates) ( filter (not.prime) [1100..10^6]))

primeCenterCandidates :: Integer -> [Integer]
primeCenterCandidates n = [x | x <- myDivs n, let y = div n x, rem (x + y) 4 == 0, div (x + y) 4 < x]

myDivs :: Integer -> [Integer]
myDivs n = nub $ concat [ [x,y] | x <- [1..limit], rem n x == 0, let y = div n x] where
    limit = (floor.sqrt.fromIntegral) n
