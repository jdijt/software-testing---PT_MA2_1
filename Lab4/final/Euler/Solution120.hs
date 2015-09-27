module Solution120 where

solution120 :: Integer
solution120 = sum (map (\x -> x * (x - 2 + x `mod` 2)) [3..1000])
