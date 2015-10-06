module Assignment5 where

import Lecture6

carmichael :: [Integer]
carmichael = [(6*k+1)*(12*k+1)*(18*k+1) | k <- [2..], isPrime (6*k+1), isPrime (12*k+1), isPrime (18*k+1)]



getFermatResults :: Int -> Integer -> [Integer] -> IO [Bool]
getFermatResults _ 0 _      = return []
getFermatResults k n (c:cs) = do
    r <- prime_tests_F k c
    rs <- getFermatResults k (n-1) cs
    return (r: rs) 


countDetectedNumbers :: Int -> IO [(Int,Int)]
countDetectedNumbers 0 = return []
countDetectedNumbers n = do
    results <- getFermatResults n 100 carmichael
    cs <- countFermatFailures (n-1)
    return ( (n,(length $ filter (\x -> not x) results)) : cs)
