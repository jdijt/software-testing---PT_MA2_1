module Assignment7 where

import Data.List
import Lecture4
import Test.QuickCheck

import Assignment5
import Assignment6


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


-- Combine all properties for trClos and symClos.
prop_transTest :: Ord a => Rel a -> Rel a -> Bool
prop_transTest input result = prop_isOrdered result
                            && prop_noDup result
                            && prop_containsOriginal input result
                            && prop_isTrans result

prop_symTest :: Ord a => Rel a -> Rel a -> Bool
prop_symTest input result = prop_isOrdered result
                            && prop_noDup result
                            && prop_containsOriginal input result
                            && prop_isSym result


genArbitraryRel :: Gen (Rel Int)
genArbitraryRel = do
                    size <- choose (0,4)
                    sublistOf [(x,y) | x <- [0..size], y <- [0..size]]

trClosTest :: Property
trClosTest = forAll genArbitraryRel (\ x -> prop_transTest x (trClos x))

symClosTest :: Property
symClosTest = forAll genArbitraryRel (\ x -> prop_symTest x (symClos x))
