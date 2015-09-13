module Problem31 where

count :: Integer -> [Integer] -> Integer
count _ [] = 0
count x (y:ys) | x < 0 = 0
          | x == 0 = 1
          | otherwise = count (x - y) (y:ys) + count x ys

solution31 :: Integer
solution31 = count 200 [200,100,50,20,10,5,2,1]
