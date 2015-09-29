module Utils

where

import Domain

replaceAtIndex :: Int -> a -> [a] -> [a]
replaceAtIndex n item ls = a ++ (item:b) where (a, _:b) = splitAt n ls

isSolved :: Int -> Int -> SudokuProblem -> Bool
isSolved x y (SP sp) = spotSolved ((sp !! y) !! x)

hasValue :: Int -> Int -> Int -> SudokuProblem -> Bool
hasValue n x y (SP sp) = spotHasValue n ((sp !! y) !! x)

spotSolved :: Spot -> Bool
spotSolved (Known _) = True
spotSolved _ = False

spotHasValue :: Int -> Spot -> Bool
spotHasValue n (Known m) = n == m
spotHasValue _ _ = False
