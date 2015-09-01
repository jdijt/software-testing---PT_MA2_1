module Euler10 where


-- Code for generating primes taken from The Haskell Road to Logic, Maths and Programming (Chapter 1.83, page 23):
ldp :: Integer -> Integer
ldp n = ldpf primes n

ldpf :: [Integer] -> Integer -> Integer
ldpf (p:ps) n 
	| rem n p == 0	= p
	| p^2 > n		= n
	| otherwise		= ldpf ps n

prime :: Integer -> Bool
prime n
	| n < 1		= error "not a positive integer"
	| n == 1	= False
	| otherwise	= ldp n == n
	
primes :: [Integer]
primes = 2 : filter prime [3..]
-- End of code taken from The Haskell Road to Logic, Maths and Programming.


primeSum :: Integer
primeSum = sum $ takeWhile (2000000>) primes
