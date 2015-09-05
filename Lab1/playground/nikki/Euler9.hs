{- 

Euler 9: Pythagoras Triple
Nikki van Ommeren
10017704
05 - 09 - 2015

-}

module Euler9 where


triplet' :: [Integer] -> [(Integer, Integer, Integer)]
triplet' [] = []
triplet' (z:zs) = [ (x,y,z) | x <- [2..z], y <- [2..z], z^2 == x^2 + y^2] ++ triplet' zs

triplet :: [(Integer, Integer, Integer)]
triplet = triplet' [2..]