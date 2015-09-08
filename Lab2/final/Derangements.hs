module Derangements where

import Data.List
import Permutations

isDerangement :: Eq a => [a] -> [a] -> Bool
isDerangement xs ys = isPermutation xs ys && isDerangement' xs ys where
    isDerangement' [] [] = True
    isDerangement' (x:xs) (y:ys) = x /= y && isDerangement' xs ys
    isDerangement' _ _ = False

deran :: Int -> [[Int]]
deran n = filter (isDerangement xs) $ permutations xs where
    xs = [0..n-1]