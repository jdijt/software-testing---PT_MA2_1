module ModularExp

where


exM :: Integer -> Integer -> Integer -> Integer
exM x 1 n = rem x n
exM x y n = rem (x * exM x (y-1) n ) n
