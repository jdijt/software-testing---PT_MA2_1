module IBAN where 

import Data.Char
import Data.List

valIban :: String -> Bool
valIban xs = mod (iban xs) 97 == 1

iban :: String -> Integer
iban xs = (toDigits . adaptLetters . moveHeader . removeSpaces) xs

toDigits :: [Integer] -> Integer
toDigits xs = read (concat $ map show xs) :: Integer

adaptLetters :: String -> [Integer]
adaptLetters [] = []
adaptLetters (x:xs) = if isAlpha x then toInteger(ord x - 55):adaptLetters xs
	                  else (toInteger . digitToInt) x:adaptLetters xs

moveHeader :: String -> String
moveHeader xs = drop 4 xs ++ take 4 xs

removeSpaces :: String -> String
removeSpaces [] = []
removeSpaces (x:xs) = if isSpace x then removeSpaces xs
	                  else x:removeSpaces xs

