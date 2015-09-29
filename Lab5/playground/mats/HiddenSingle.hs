module HiddenSingle

where

import Domain
import Utils

solableInGroup :: [(Int, Int, Spot)] -> [(Int, Int, Int)]
solableInGroup xs = map (\(n,(x,y,_):_) -> (n,x,y)) $ filter (\(_,sps) -> length sps == 1) [ (n, filter (spotHasPossibility n) xs) | n <- [1..9], n `notElem` known] where
  known = knownValues2 xs

-- solveableInRow :: [Spot] -> [(Int, Int)]
-- solveableInRow xs = map (\(n,x:_) -> (n,x)) $ filter (\(_,xs) -> length xs == 1) [ (n, filter (\q -> spotHasPossibility n (1,1,(xs !! q))) [0..8]) | n <- [1..9], n `notElem` known] where
  -- known = knownValues xs

getRow :: SudokuProblem -> Int -> [(Int, Int, Spot)]
getRow (SP ps) n = [(x,n,sp) | x<-[0..8], let sp = (ps !! n) !! x]

allGroups :: SudokuProblem -> (SudokuProblem -> Int -> [(Int, Int, Spot)]) -> [[(Int, Int, Spot)]]
allGroups sp f = map (f sp) [0..8]

getColumn :: SudokuProblem -> Int -> [(Int, Int, Spot)]
getColumn (SP ps) n = [(n,y,sp) | y<-[0..8], let sp = (ps !! y) !! n]

asGroups :: SudokuProblem -> [[(Int, Int, Spot)]]
asGroups sp = allGroups sp getRow ++ allGroups sp getColumn

hiddenSingle :: SudokuProblem -> [SudokuAction]
hiddenSingle (SP ps) = map (\(n,x,y) -> SetValue n x y) $ concatMap solableInGroup (asGroups (SP ps))

spotHasPossibility :: Int -> (Int, Int, Spot) -> Bool
spotHasPossibility n (_,_,Unknown m) = n `elem` m
spotHasPossibility _ _ = False


knownValues2 :: [(Int, Int, Spot)] -> [Int]
knownValues2 [] = []
knownValues2 ((_,_,Known n):xs) = n : knownValues2 xs
knownValues2 ((_,_,Unknown _):xs) = knownValues2 xs


knownValues :: [Spot] -> [Int]
knownValues [] = []
knownValues (Known n:xs) = n : knownValues xs
knownValues (Unknown _:xs) = knownValues xs
