module Euler9 where


euler9 :: Integer
euler9 = head [a * b * c | a <- [1..1000], b <- [1..a], let c = 1000 - a - b, a^2 + b^2 == c^2]
