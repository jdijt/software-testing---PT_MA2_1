module Assignment1

where

import Numeric (showIntAtBase)
import Data.Char (intToDigit)
import Lecture6 (multM)

--Taken from http://stackoverflow.com/a/1959792/2307346
toBinary :: Int -> [Char]
toBinary n = showIntAtBase 2 intToDigit n ""

getPowersOfTwo :: Integer -> Integer -> Int -> [Integer]
getPowersOfTwo a c max = foldl (\xs@(h:_) _ -> multM h h c : xs) [a] [1..max]

shouldCombine :: Char -> Integer -> Integer
shouldCombine '1' n = n
shouldCombine _ _ = 1

exM :: Integer -> Int -> Integer -> Integer
exM a b 0 = error "mod 0 not allowed"
exM a b c = (product $ zipWith shouldCombine binary (getPowersOfTwo a c (length binary - 1))) `mod` c
    where
        binary = toBinary b
