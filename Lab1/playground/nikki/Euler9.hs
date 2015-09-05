{- 

Euler 9: Pythagoras Triple
Nikki van Ommeren
10017704
05 - 09 - 2015

-}

module Euler9 where

-- |Returns all Pythagoras triples which has the value z from a list 
triplet :: [Integer] -> [(Integer, Integer, Integer)]
triplet [] = []
triplet (z:zs) = [ (x,y,z) | x <- [2..z], y <- [2..z], z^2 == x^2 + y^2] ++ triplet zs

-- |Finds the product of the Pythagoras Triple for which x + y + z = 1000
findTriplet :: Integer
findTriplet = head (take 1 [ (x*y*z) | (x,y,z) <- triplet [400..], x + y + z == 1000])