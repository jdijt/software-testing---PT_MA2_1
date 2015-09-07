module Permutations where

import Data.List

isPermutation :: Eq a => [a] -> [a] -> Bool
isPermutation [] [] = True
isPermutation [] _ = False
isPermutation (x:xs) ys = x `elem` ys && (isPermutation xs (delete x ys))
