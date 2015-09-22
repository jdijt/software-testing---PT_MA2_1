module Solution120 where

totalRemains :: [Integer] -> Integer -> Integer
totalRemains [] r = r
totalRemains (x:xs) s = if odd x then totalRemains xs (s + remainOdd)  
						    else totalRemains xs (s + remainEven) 
						    where remainOdd = x * (x - 1)
						    	  remainEven = (x - 1) * (x - 2) + x - 2

solution120 :: Integer 
solution120 = totalRemains [3..1000] 0