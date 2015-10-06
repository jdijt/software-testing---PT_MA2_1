module Assignment1 where

import Numeric


-- Base -> Modulo -> [(power, result)];
powersOfTwoM :: Integer -> Integer -> [Integer]
powersOfTwoM b m = (b `rem` m) : nextPower (powersOfTwoM b m)
    where
    nextPower :: [Integer] -> [Integer]
    nextPower (a:as) = ((a * a) `rem` m) : nextPower as


intToBinary :: Integer -> String
intToBinary n = reverse $ (showIntAtBase 2 charMap n) ""
    where
    charMap :: Int -> Char
    charMap 0 = '0'
    charMap 1 = '1'


-- Base, exponent, modulo.
exM :: Integer -> Integer -> Integer -> Integer
exM b e m = (foldl (*) 1 $ powers) `rem` m
    where
    powers = zipWith (\x y -> if x == '0' then 1 else y) (intToBinary e) (powersOfTwoM b m)
