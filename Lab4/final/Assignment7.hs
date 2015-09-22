module Assignment7 where

import Data.List
import Lecture4
--import Assignment5
--import Assignment6


-- Postconditions, shared by symClos and trClos:


prop_isOrdered :: Ord a => Rel a -> Bool
prop_isOrdered xs = sort xs == xs

prop_noDup :: Ord a => Rel a -> Bool
prop_noDup xs = (length.nub) xs == length xs

prop_containsOriginal :: Ord a => Rel a -> Rel a -> Bool
prop_containsOriginal rs new = all (`elem` new) rs

-- Properties for symClos:
prop_isSym :: Ord a => Rel a -> Bool
prop_isSym xs = all (\(x,y) -> (y,x) `elem` xs) xs


-- Properties for trClos:

-- Based on the implementation for Sets provided at The Haskell Road to Logic ch. 5.3
prop_isTrans :: Ord a => Rel a -> Bool
prop_isTrans rs = and [ trans r rs | r <- rs]
    where
    trans :: Ord a => (a,a) -> Rel a -> Bool
    trans (x,y) xs = and [(x,v) `elem` xs | (u,v) <- xs, u == y]
