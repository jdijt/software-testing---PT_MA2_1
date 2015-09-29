module Assignment7 where

import Lecture5 as L5
import Assignment1 as A1


getAvgHintsA1Sudokus :: Int -> IO ()
getAvgHintsA1Sudokus n = do
    is <- genRandomInstances (A1.genRandomSudoku >>= A1.genProblem) n
    print $ (fromIntegral $ sum $ map (length.A1.filledPositions.fst) is) / (fromIntegral n)

getAvgHintsL5Sudokus :: Int -> IO ()
getAvgHintsL5Sudokus n = do
    is <- genRandomInstances (L5.genRandomSudoku >>= L5.genProblem) n
    print $ (fromIntegral $ sum $ map (length.L5.filledPositions.fst) is) / (fromIntegral n)


genRandomInstances :: (IO a) -> Int -> IO [a]
genRandomInstances _ 0 = return []
genRandomInstances gen x = do
        i <- gen
        is <- genRandomInstances gen (x-1)
        return (i:is)
    
