module Derangements where

import Data.List
import Permutations

isDerangement :: Eq a => [a] -> [a] -> Bool
isDerangement xs ys = isPermutation xs ys && isDerangement' xs ys where
    isDerangement' [] [] = True
    isDerangement' (x:xs) (y:ys) = x /= y && isDerangement' xs ys
    isDerangement' _ _ = False

deran :: Eq a => [a] -> [[a]]
deran x = filter (isDerangement x) $ permutations x

--deran (x:xs) = concat (map (insrt x) (deran xs)) where
--  insrt x [] = [[x]]
--  insrt x (y:ys) = (x:y:ys) : map (y:) (insrt x ys)