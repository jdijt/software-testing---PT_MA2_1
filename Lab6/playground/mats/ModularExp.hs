module ModularExp

where

import Numeric
import Data.Char

toBase :: Integer -> Integer -> [Int]
toBase base num = map  digitToInt(showIntAtBase base intToDigit num "")

base2modPowers :: Integer -> [Int] -> Integer -> [Integer]
base2modPowers a xs c = foldr (\_ (b:bs) -> (b * b) `mod` c : b :  bs)  [a `mod` c] (init xs)

exM2 :: Integer -> Integer -> Integer -> [Integer]
exM2 x y z = exM2' x y z bBits 0 1 where
  bBits = reverse (toBase 2 y)
  exM2' :: Integer -> Integer -> Integer -> [Int] -> Integer -> Integer -> [Integer]
  exM2' _ _ _ [] _ _ = []
  exM2' a b c (bi:bis) _ 1 = let v' = a `mod` c in if bi == 1
                                                   then v' : exM2' a b c bis v' 2
                                                   else exM2' a b c bis v' 2
  exM2' a b c (bi:bis) v n | n > b = []
                           | otherwise = let v' = (v*v) `mod` c in if bi == 1
                                                                then v' : exM2' a b c bis v' 2
                                                                else exM2' a b c bis v' 2

exM :: Integer -> Integer -> Integer -> Integer
exM a b c = product (map fst $ filter (\q -> snd q == 1) (zip (base2modPowers a bBits c) bBits)) `mod` c where
  bBits = toBase 2 b
