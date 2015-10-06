module ModularExp

where

import Numeric
import Data.Char

toBase :: Integer -> Integer -> [Int]
toBase base num = map  digitToInt(showIntAtBase base intToDigit num "")

exM :: Integer -> Integer -> Integer -> Integer
exM x y z = product (zipWith (\a b -> if a == 1 then b else 1) bBits modPowers) `mod` z where
  bBits = reverse (toBase 2 y)
  initial = x `mod` z
  modPowers = initial : exM' x y z initial
  exM' a b c v = let v' = (v*v) `mod` c in v' : exM' a b c v'
