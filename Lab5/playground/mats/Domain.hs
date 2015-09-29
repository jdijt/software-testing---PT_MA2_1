module Domain
where

import Data.Char

data Spot = Unknown [Int] | Known Int
instance Show Spot where
  show (Unknown xs) = [chr (96 + length xs)]
--show (Unknown _) = " "
  show (Known i) = show i

data SudokuProblem = SP [[Spot]]
instance Show SudokuProblem where
  show (SP ps) = show (sudokuProblemString (SP ps))

data SudokuAction = SetValue Int Int Int | ScrapValue Int Int Int deriving (Show)

barString :: String
barString = "+-------+-------+-------+\n"

lineString :: [Spot] -> String
lineString [] = "|\n"
lineString (x:y:z:zs) = "| " ++ show x ++ " " ++ show y ++ " " ++ show z ++ " " ++ lineString zs

sudokuProblemString :: SudokuProblem -> String
sudokuProblemString (SP [a1,a2,a3,a4,a5,a6,a7,a8,a9]) = concat [barString
                                                ,lineString a1
                                                ,lineString a2
                                                ,lineString a3
                                                ,barString
                                                ,lineString a4
                                                ,lineString a5
                                                ,lineString a6
                                                ,barString
                                                ,lineString a7
                                                ,lineString a8
                                                ,lineString a9
                                                ,barString]

type Weight = Int
type ActionProvider = SudokuProblem -> [SudokuAction]
type SudokuStrategy = (Int, ActionProvider)
