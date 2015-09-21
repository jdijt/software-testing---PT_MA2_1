module Assignment3 where 

import SetOrd
import System.Random
import Test.QuickCheck

intersectionSet :: (Ord a) => Set a -> Set a -> Set a
intersectionSet (Set []) set2 = Set []
intersectionSet (Set xs) set2 = Set [ x | x <- xs , inSet x set2]


-- |unionSet is already defined in SetOrd.hs 

differenceSet :: (Ord a) => Set a -> Set a -> Set a
differenceSet (Set []) set2 = Set []
differenceSet (Set xs) set2 = Set [ x | x <- xs , not(inSet x set2)]
