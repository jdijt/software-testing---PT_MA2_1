module Euler.Problem9 where

solution :: Integer
solution = head [a*b*c| a <- [1..500], b <- [1..a], c <- [1000-b-a],  ((a^2) + (b^2)) == (c^2)]


