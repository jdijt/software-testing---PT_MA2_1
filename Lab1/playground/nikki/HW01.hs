{-# OPTIONS_GHC -Wall #-}
module HW01 where

-- Exercise 1 -----------------------------------------

-- Get the last digit from a number
lastDigit :: Integer -> Integer
lastDigit x = x `mod` 10 

-- Drop the last digit from a number
dropLastDigit :: Integer -> Integer
dropLastDigit x = x `div` 10

-- Exercise 2 -----------------------------------------

toRevDigits :: Integer -> [Integer]
toRevDigits x | x <= 0 = []
<<<<<<< HEAD
              | otherwise = lastDigit x:(toRevDigits . dropLastDigit) x  
=======
              | otherwise = lastDigit x:(toRevDigits . dropLastDigit) x 
>>>>>>> 7113cd8f8c72ae5ebb3acfaeb07c8f2a94cdaa5e

-- Exercise 3 -----------------------------------------

-- Double every second number in a list starting on the left.
doubleEveryOther :: [Integer] -> [Integer]
doubleEveryOther [] = []
doubleEveryOther [x] = [x] 
doubleEveryOther (x:y:zs) = x:y*2:doubleEveryOther zs

-- Exercise 4 -----------------------------------------

-- Calculate the sum of all the digits in every Integer.
sumDigits :: [Integer] -> Integer
sumDigits [] = 0
sumDigits (x:xs) = if x > 9 then sumDigits (toRevDigits x ++ xs)
                   else x + sumDigits xs

-- Exercise 5 -----------------------------------------

-- Validate a credit card number using the above functions.
luhn :: Integer -> Bool
luhn x = (lastDigit . sumDigits . doubleEveryOther . toRevDigits) x == 0
<<<<<<< HEAD
=======

-- Exercise 6 -----------------------------------------

-- Towers of Hanoi for three pegs
type Peg = String
type Move = (Peg, Peg)

hanoi :: Integer -> Peg -> Peg -> Peg -> [Move]
hanoi = undefined
>>>>>>> 7113cd8f8c72ae5ebb3acfaeb07c8f2a94cdaa5e
