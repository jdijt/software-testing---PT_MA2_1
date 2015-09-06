module Euler where

import Primes

-- For a < b < c
-- We can conclude that a <= 333 and b <= 499
solution9 :: Integer
solution9 = head [a * b * c | a <- [1..333], b <- [a..499], let c = 1000 - a - b, a^2 + b^2 == c^2]

