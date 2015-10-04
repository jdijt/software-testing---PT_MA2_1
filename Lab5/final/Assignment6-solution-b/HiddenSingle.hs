module HiddenSingle

where

import Domain
import Control.Arrow
import Utils

hiddenSingle :: SudokuProblem -> [SudokuAction]
hiddenSingle prob = map (\(n,p) -> SetValue n (fst p)) solvableCstrnt where
  solvableCstrnt :: [(Int, ((Row,Column),Spot))]
  solvableCstrnt = concatMap (solvableInConstraint . map (\q -> (q, prob q))) allConstraints

solvableInConstraint :: [(Coordinate, Spot)] -> [(Int, (Coordinate, Spot))]
solvableInConstraint xs = map (second head) $ filter (\(_,sps) -> length sps == 1) (spotsForUnknownValues unknownVals)
  where
  spotsForUnknownValues :: [Int] -> [(Int,[(Coordinate, Spot)])]
  spotsForUnknownValues = map (\n -> (n, filter (spotHasPossibility n) xs))
  unknownVals :: [Int]
  unknownVals = filter (`notElem` knownValues xs) [1..9]

getRow :: SudokuProblem -> Int -> [(Int, Int, Spot)]
getRow prob n = [(x,n,sp) | x<-[1..9], let sp = prob (n,x)]

allGroups :: SudokuProblem -> (SudokuProblem -> Int -> [(Int, Int, Spot)]) -> [[(Int, Int, Spot)]]
allGroups sp f = map (f sp) [1..9]

getColumn :: SudokuProblem -> Int -> [(Int, Int, Spot)]
getColumn prob n = [(n,y,sp) | y<-[1..9], let sp = prob (y,n)]

asGroups :: SudokuProblem -> [[(Int, Int, Spot)]]
asGroups sp = allGroups sp getRow ++ allGroups sp getColumn

knownValues :: [(Coordinate, Spot)] -> [Int]
knownValues [] = []
knownValues ((_,Known n):xs) = n : knownValues xs
knownValues ((_,Unknown _):xs) = knownValues xs
