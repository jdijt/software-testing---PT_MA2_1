module Assignment7 where

-- Use lecture 5 by default, add A1 to for generating with the A1 code.
import Lecture5 as L5
import Assignment1 as A1


getAvgHintsA1Sudokus :: Int -> IO ()
getAvgHintsA1Sudokus n = do
    is <- genRandomInstances (A1.genRandomSudoku >>= A1.genProblem) n
    print ((fromIntegral $ sumHints A1.filledPositions is) / (fromIntegral n))

getAvgHintsL5Sudokus :: Int -> IO ()
getAvgHintsL5Sudokus n = do
    is <- genRandomInstances (L5.genRandomSudoku >>= L5.genProblem) n
    print ((fromIntegral $ sumHints L5.filledPositions is) / (fromIntegral n))


sumHints :: (a -> [b]) -> [(a,c)] -> Int
sumHints f = foldl (\x y -> x + ((length.f.fst) y)) 0 

genRandomInstances :: (IO a) -> Int -> IO [a]
genRandomInstances _ 0 = return []
genRandomInstances gen x = do
        i <- gen
        is <- genRandomInstances gen (x-1)
        return (i:is)
    
