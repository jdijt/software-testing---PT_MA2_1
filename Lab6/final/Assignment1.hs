module Assignment1(exM) where

import Numeric
import Data.Char

-- Infinite list of powers of 2 under modulo m.
-- [a `rem` m, a^2 `rem` m, a^4 `rem` m,...]
powersOfTwoM :: Integer -> Integer -> [Integer]
powersOfTwoM b m = (b `rem` m) : nextPower (powersOfTwoM b m)
    where
    nextPower (a:as) = ((a * a) `rem` m) : nextPower as


-- Returns binary representation of the given integer with the least significant bit on the left side of the string.
intToBinary :: Integer -> String
intToBinary n = reverse (showIntAtBase 2 intToDigit n "")


exM :: Integer -> Integer -> Integer -> Integer
exM b e m = product powers `rem` m
    where
    powers = zipWith (\x y -> if x == '0' then 1 else y) (intToBinary e) (powersOfTwoM b m)
