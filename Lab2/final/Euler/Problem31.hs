module Problem31 where

import Data.List 

count :: Integer -> [Integer] -> Integer
count x [] = 0
count x y | x < 0 = 0
          | x == 0 = 1
          | otherwise = count (x - m) y + count x (delete m y) 
            where m = maximum y

solution31 :: Integer
solution31 = count 200 coins where coins = [200,100,50,20,10,5,2,1]