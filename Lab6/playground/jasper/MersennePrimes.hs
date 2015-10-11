module MersennePrimes where

import Lecture6
import Control.Monad

mersenneCandidates :: [Integer]
mersenneCandidates = map (\x -> 2^x - 1) primes

mersennePrimes :: Int -> [Integer] -> IO ()
mersennePrimes 0 _      = putStrLn "Done"
mersennePrimes n (c:cs) = do
    isPrime <- primeMR 3 c
    when isPrime (putStrLn (show c))
    mersennePrimes (if isPrime then n-1 else n) cs 
