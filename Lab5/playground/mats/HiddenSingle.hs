module HiddenSingle

where

import Domain
import Control.Arrow
import Utils

solvableInConstraint :: [((Row,Column), Spot)] -> [(Int, ((Row,Column), Spot))]
solvableInConstraint xs = map (second head) $ filter (\(_,sps) -> length sps == 1) (spotsForUnknownValues unknownVals)
  where
  spotsForUnknownValues :: [Int] -> [(Int,[((Row,Column), Spot)])]
  spotsForUnknownValues = map (\n -> (n, filter (spotHasPossibility n) xs))
  unknownVals :: [Int]
  unknownVals = filter (`notElem` knownValues xs) [1..9]

-- solableInGroup :: [(Int, Int, Spot)] -> [(Int, Int, Int)]
-- solableInGroup xs = map (\(n,(x,y,_):_) -> (n,x,y)) $ filter (\(_,sps) -> length sps == 1) [ (n, filter (spotHasPossibility n) xs) | n <- [1..9], n `notElem` known] where
  -- known = knownValues xs

getRow :: SudokuProblem -> Int -> [(Int, Int, Spot)]
getRow prob n = [(x,n,sp) | x<-[1..9], let sp = prob (n,x)]

allGroups :: SudokuProblem -> (SudokuProblem -> Int -> [(Int, Int, Spot)]) -> [[(Int, Int, Spot)]]
allGroups sp f = map (f sp) [1..9]

getColumn :: SudokuProblem -> Int -> [(Int, Int, Spot)]
getColumn prob n = [(n,y,sp) | y<-[1..9], let sp = prob (y,n)]

asGroups :: SudokuProblem -> [[(Int, Int, Spot)]]
asGroups sp = allGroups sp getRow ++ allGroups sp getColumn

hiddenSingle :: SudokuProblem -> [SudokuAction]
hiddenSingle prob = map (\(n,p) -> SetValue n (fst p)) solvableCstrnt where
  solvableCstrnt :: [(Int, ((Row,Column),Spot))]
  solvableCstrnt = concatMap (solvableInConstraint . map (\q -> (q, prob q))) allConstraints

spotHasPossibility :: Int -> ((Row,Column), Spot) -> Bool
spotHasPossibility n (_,Unknown m) = n `elem` m
spotHasPossibility _ _ = False

knownValues :: [((Row,Column), Spot)] -> [Int]
knownValues [] = []
knownValues ((_,Known n):xs) = n : knownValues xs
knownValues ((_,Unknown _):xs) = knownValues xs
