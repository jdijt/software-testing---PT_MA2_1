{-# OPTIONS_GHC -Wall #-}
module HW01 where

-- Exercise 1 -----------------------------------------

-- Get the last digit from a number
lastDigit :: Integer -> Integer
lastDigit n = n `mod` 10

-- Drop the last digit from a number
dropLastDigit :: Integer -> Integer
dropLastDigit n = n `div` 10

-- Exercise 2 -----------------------------------------
toRevDigits :: Integer -> [Integer]
toRevDigits x | x <= 0 = []
              | otherwise = lastDigit x : (toRevDigits . dropLastDigit) x

-- Exercise 3 -----------------------------------------

-- Double every second number in a list starting on the left.
doubleEveryOther :: [Integer] -> [Integer]
doubleEveryOther [] = []
doubleEveryOther [x] = [x]
doubleEveryOther (x:y:rest) = x : y*2 : doubleEveryOther rest

-- Exercise 4 -----------------------------------------

-- Calculate the sum of all the digits in every Integer.
-- We chose for 1 + mod x 10 because this function will only be used within the context of creditcards.
-- The highest number within this context is 18.
sumDigits :: [Integer] -> Integer
sumDigits [] = 0
sumDigits (x:xs) | x < 10 = x + sumDigits xs
                 | otherwise = 1 + mod x 10 + sumDigits xs

-- Exercise 5 -----------------------------------------

-- Validate a credit card number using the above functions.
luhn :: Integer -> Bool
luhn x = (lastDigit . sumDigits . doubleEveryOther . toRevDigits) x == 0