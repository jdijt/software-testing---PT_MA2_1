module HW01 where

lastDigit :: Integer -> Integer
lastDigit n = n `mod` 10


dropLastDigit :: Integer -> Integer
dropLastDigit n = n `div` 10


toRevDigits :: Integer -> [Integer]
toRevDigits 0 = []
toRevDigits n
	| n < 0		= []
	| otherwise	= lastDigit n: (toRevDigits $ dropLastDigit n)


doubleEveryOther :: [Integer] -> [Integer]
doubleEveryOther [] = []
doubleEveryOther [x] = [x]
doubleEveryOther (x:y:xs) = [x, y*2] ++ doubleEveryOther xs


sumDigits :: [Integer] -> Integer
sumDigits [] = 0
sumDigits (x:xs)
	| x >= 10	= (sum $ toRevDigits x) + sumDigits xs
	| otherwise	= x + sumDigits xs


luhn :: Integer -> Bool
luhn x = (sumDigits $ doubleEveryOther $ toRevDigits x) `mod` 10 == 0
