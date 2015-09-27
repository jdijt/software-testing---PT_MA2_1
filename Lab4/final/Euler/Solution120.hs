module Solution120 where

totalRemains :: [Integer] -> Integer
totalRemains [] = 0
totalRemains (x:xs) | odd x = remainOdd + totalRemains xs
					| otherwise = remainEven + totalRemains xs
						    where remainOdd = x * (x - 1)
						    	  remainEven = x * (x - 2)

-- Solution Mats
-- parity :: Integer -> Integer
-- parity = (`mod` 2)
-- totalRemains :: [Integer] -> Integer
-- totalRemains xs = sum (map (\x -> x * (x - 2 + parity x)) xs)

solution120 :: Integer
solution120 = totalRemains [3..1000]
