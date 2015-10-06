module Assignment1 where

exM :: Integer -> Integer -> Integer -> Integer
exM x n m | odd(n) = (x `mod` m) * exM x (n - 1) m
          | n == 2 = x^2 `mod` m
          | otherwise = exM (x^2) (n `div` 2) m