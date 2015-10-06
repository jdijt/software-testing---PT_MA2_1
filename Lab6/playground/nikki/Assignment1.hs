module Assignment1 where

import Numeric (showHex, showIntAtBase)
import Data.Char (intToDigit, digitToInt)

-- |Version 1
exM :: Integer -> Integer -> Integer -> Integer
exM x n m | odd(n) = (x `mod` m) * exM x (n - 1) m `mod` m
          | n == 2 = x^2 `mod` m
          | otherwise = exM (x^2) (n `div` 2) m

-- |Version 2, more efficient
exM' :: Integer -> Integer -> Integer -> Integer
exM' x n m = product (modList x (splitBinary (toBinary n) 0) m 0 1) `mod` m

modList x [] m s t = []
modList x (n:ns) m s t | t == 1 = x^n `mod` m : modList x ns m (x^n `mod` m) (2*n)
                       | t == n = s^2 `mod` m : modList x ns m (s^2 `mod` m) (2*t) 
                       | otherwise = modList x (n:ns) m (s^2 `mod` m) (2*t) 

splitBinary [] n = []
splitBinary (x:xs) n | x == '0' = splitBinary xs (n+1)
                     | otherwise = [digitToInt(x) * 2^n] ++ splitBinary xs (n+1)

-- |Source: http://stackoverflowsp.com/questions/1959715/
--  how-to-print-integer-literals-in-binary-or-hex-in-haskell
toBinary x = reverse (showIntAtBase 2 intToDigit x "")