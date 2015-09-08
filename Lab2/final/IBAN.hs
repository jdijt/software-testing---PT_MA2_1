module IBAN where 

import Data.Char
import Data.List

valIban :: String -> Bool
valIban xs = mod (iban xs) 97 == 1

iban :: String -> Int
iban xs = (toDigits . adaptLetters . moveHeader . removeSpaces) xs

toDigits :: [Int] -> Int
toDigits xs = read (concat $ map show xs) :: Int

adaptLetters :: String -> [Int]
adaptLetters [] = []
adaptLetters (x:xs) = if isAlpha x then (ord x - 55):adaptLetters xs
	                  else digitToInt x:adaptLetters xs

moveHeader :: String -> String
moveHeader xs = drop 4 xs ++ take 4 xs

removeSpaces :: String -> String
removeSpaces [] = []
removeSpaces (x:xs) = if isSpace x then removeSpaces xs
	                  else x:removeSpaces xs

