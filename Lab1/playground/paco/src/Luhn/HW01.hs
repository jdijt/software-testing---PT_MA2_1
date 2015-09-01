{-# OPTIONS_GHC -Wall #-}
module Luhn.HW01 where

-- Exercise 1 -----------------------------------------

-- Get the last digit from a number
lastDigit :: Integer -> Integer
lastDigit n = mod n 10

-- Drop the last digit from a number
dropLastDigit :: Integer -> Integer
dropLastDigit n = div n 10

-- Exercise 2 -----------------------------------------
toRevDigits :: Integer -> [Integer]
toRevDigits x | x <= 0 = []
              | otherwise = (lastDigit x) : (toRevDigits (dropLastDigit x))

-- Exercise 3 -----------------------------------------

-- Double every second number in a list starting on the left.
doubleEveryOther :: [Integer] -> [Integer]
doubleEveryOther [] = []
doubleEveryOther [x] = [x]
doubleEveryOther (x:y:rest) = x : (y*2) : doubleEveryOther rest

-- Exercise 4 -----------------------------------------

-- Calculate the sum of all the digits in every Integer.
sumDigits :: [Integer] -> Integer
sumDigits [] = 0
sumDigits (x:xs) | x < 10 = x + sumDigits xs
                 | otherwise = splitAndCount x + sumDigits xs where
            splitAndCount :: Integer -> Integer
            splitAndCount 0 = 0
            splitAndCount d = lastDigit d + splitAndCount (dropLastDigit d)


-- Exercise 5 -----------------------------------------

-- Validate a credit card number using the above functions.
luhn :: Integer -> Bool
luhn x = rem (sumDigits $ doubleEveryOther $ toRevDigits x) 10 == 0