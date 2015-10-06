module ModularExp

where

import Numeric
import Data.Char

toBase :: Integer -> Integer -> [Int]
toBase base num = map digitToInt(showIntAtBase base intToDigit num "")

base2modPowers :: Integer -> [Int] -> Integer -> [Integer]
base2modPowers a xs c = foldr (\_ (b:bs) -> (b * b) `mod` c : b :  bs)  [a `mod` c] (init xs)

exM :: Integer -> Integer -> Integer -> Integer
exM a b c = product (map fst $ filter (\q -> snd q == 1) (zip (base2modPowers a bBits c) bBits)) `mod` c where
  bBits = toBase 2 b
