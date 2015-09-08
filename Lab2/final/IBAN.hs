module IBAN where 

import Data.Char
import Data.List

iban :: String -> Bool
iban xs = mod (iban' xs) 97 == 1

iban' :: String -> Integer
iban' xs = (toDigits . adaptLetters . moveHeader . removeNonAlphaNum) xs

toDigits :: [Integer] -> Integer
toDigits xs = read (concat $ map show xs) :: Integer

adaptLetters :: String -> [Integer]
adaptLetters [] = []
adaptLetters (x:xs)
	| isAlpha x	= toInteger (ord x - 55):adaptLetters xs
	| otherwise = (toInteger . digitToInt) x:adaptLetters xs

moveHeader :: String -> String
moveHeader xs = drop 4 xs ++ take 4 xs

removeNonAlphaNum :: String -> String
removeNonAlphaNum = filter isAlphaNum 

