module Assignment1

where

import Numeric (showHex, showIntAtBase)
import Data.Char (intToDigit)
import Lecture6 hiding (exM)

--Taken from http://stackoverflow.com/a/1959792/2307346
toBinary :: Int -> String
toBinary c = reverse $ showIntAtBase 2 intToDigit c ""

--getPowersOfTwo :: [Char] -> [Int]
--getPowersOfTwo [] = []
--getPowersOfTwo ('1':t) = 2 ^ (length t) : getPowersOfTwo t
--getPowersOfTwo ('0':t) = getPowersOfTwo t

--getModPower :: Integer -> Integer -> [Int] -> [Integer]
--getModPower a b xs = map (\x -> (a ^ x) `mod` b) xs

getPowersOfTwo a b binary = foldl (\x y -> multM (head x) (head x) b : x) [a] [1..(length(binary) -1)]

--myzip powers binary =

shouldTake :: Char -> Integer -> Integer
shouldTake '1' n = n
shouldTake _ _ = 1

--modMultiply :: Integer -> [Integer] -> Integer
--modMultiply b modPowers = foldr (\x y -> multM x y b) 1 modPowers `mod` b
--
--exM :: Integer -> Int -> Integer -> Integer
--exM a c b = modMultiply b $ getModPower a b $ getPowersOfTwo $ toBinary c