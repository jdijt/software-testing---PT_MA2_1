module Utils

where

import Data.List
import Domain

emptyProblem :: SudokuProblem
emptyProblem (_,_) = Unknown [1..9]

update :: Eq a => (a -> b) -> (a,b) -> a -> b
update f (y,z) x = if x == y then z else f x

replaceAtIndex :: Int -> a -> [a] -> [a]
replaceAtIndex n item ls = a ++ (item:b) where (a, _:b) = splitAt n ls

isSolved :: Row -> Column -> SudokuProblem -> Bool
isSolved y x sp = spotSolved (sp (y,x))

hasValue :: Int -> Row -> Column -> SudokuProblem -> Bool
hasValue n x y sp = spotHasValue n (sp (y,x))

spotSolved :: Spot -> Bool
spotSolved (Known _) = True
spotSolved _ = False

spotHasValue :: Int -> Spot -> Bool
spotHasValue n (Known m) = n == m
spotHasValue _ _ = False

allSpots :: SudokuProblem -> [Spot]
allSpots prob = map snd (allSpotsCor prob)

allSpotsCor :: SudokuProblem -> [(Coordinate, Spot)]
allSpotsCor prob = [((row,col),prob (row,col)) | row <- [1..9], col <- [1..9]]

spotHasPossibility :: Int -> (Coordinate, Spot) -> Bool
spotHasPossibility n (_,Unknown m) = n `elem` m
spotHasPossibility _ _ = False


relatedSpots :: (Row,Column) -> [Coordinate]
relatedSpots x = filter (/= x) $ nub $ concat $ filter (elem x) allConstraints

allConstraints :: Constraint
allConstraints = rowConstraint ++ colConstraint ++ boxConstraint

rowConstraint :: Constraint
rowConstraint = [[(row, col) | col <- [1..9]] | row <- [1..9]]

colConstraint :: Constraint
colConstraint = [[(row, col) | row <- [1..9]] | col <- [1..9]]

boxConstraint :: Constraint
boxConstraint = [[(y,x)| x <- xb, y <-yb] | xb <- boxes, yb <- boxes] where
  boxes = [[1..3],[4..6],[7..9]]
