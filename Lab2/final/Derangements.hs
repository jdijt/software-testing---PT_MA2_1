module Derangments where

import Data.List
import Permutations

isDerangement :: Eq a => [a] -> [a] -> Bool
isDerangement xs ys = isPermutation xs ys && isDerangement' where
    isDerangement' [] [] = True
    isDerangement' (x:xs) (y:ys) = x /= y && isDerangement xs ys
    isDerangement' _ _ = False

