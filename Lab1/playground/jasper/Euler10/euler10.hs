module Euler10 where


-- Sieve implementation taken from The Haskell Road to Logic, Maths and Programming (Chapter 3.7, page 104):
sieve :: [Integer] -> [Integer]
sieve (0:xs) = sieve xs
sieve (x:xs) = x : sieve (mark xs 1 x)
	where
	mark :: [Integer] -> Integer -> Integer -> [Integer]
	mark (y:ys) k m 
		| k == m	= 0 : (mark ys 1 m)
		| otherwise	= y : (mark ys (k+1) m)

primes :: [Integer]
primes = sieve [2..]

primeSum :: Integer
primeSum = sum $ takeWhile (2000000>) primes
