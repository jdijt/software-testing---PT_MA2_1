module Assignment7 where

import Lecture5 as L5
import Assignment1 as A1


getAvgHintsA1Sudokus :: Int -> IO ()
getAvgHintsA1Sudokus n = do
    is <- generateA1Sudokus n
    print ((fromIntegral $ sumHints is) / (fromIntegral n))
    where
    sumHints :: [A1.Node] -> Int
    sumHints []     = 0
    sumHints (x:xs) = (length $ A1.filledPositions $ fst x) + sumHints xs
    
    generateA1Sudokus :: Int -> IO[A1.Node]
    generateA1Sudokus = genRandomInstances (A1.genRandomSudoku >>= A1.genProblem)

getAvgHintsL5Sudokus :: Int -> IO ()
getAvgHintsL5Sudokus n = do
    is <- generateL5Sudokus n
    print ((fromIntegral $ sumHints is) / (fromIntegral n))
    where
    sumHints :: [L5.Node] -> Int
    sumHints []     = 0
    sumHints (x:xs) = (length $ L5.filledPositions $ fst x) + sumHints xs

    generateL5Sudokus :: Int -> IO [L5.Node]
    generateL5Sudokus = genRandomInstances (L5.genRandomSudoku >>= L5.genProblem)


genRandomInstances :: (IO a) -> Int -> IO [a]
genRandomInstances _ 0 = return []
genRandomInstances gen x = do
        i <- gen
        is <- genRandomInstances gen (x-1)
        return (i:is)
    
