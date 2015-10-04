module Domain
where

data Spot = Unknown [Int] | Known Int
instance Show Spot where
  show (Unknown _) = " "
  show (Known i) = show i

type Row = Int
type Column = Int
type Coordinate = (Row,Column)
type Difficulty = Int
type SudokuProblem = Coordinate -> Spot

data SudokuAction = SetValue Int Coordinate | ScrapValue Int Coordinate | ScrapValues [Int] [Coordinate] deriving (Show)

type Constraint = [[(Row,Column)]]

barString :: String
barString = "+-------+-------+-------+\n"

lineString :: (Int -> Spot) -> String
lineString s = "| " ++ show a ++ " " ++ show b ++ " " ++ show c ++ " | " ++ show d ++ " " ++ show e ++ " " ++ show f ++ " | " ++ show g ++ " " ++ show h ++ " " ++ show i ++ " |\n" where
  [a,b,c,d,e,f,g,h,i] = [s x | x <- [1..9]]

spotString :: [Spot] -> String
spotString [] = ""
spotString (Known x:xs) = "Known: " ++ show x ++ "\n" ++ spotString xs
spotString (Unknown x:xs) = "Known: " ++ show x ++ "\n" ++ spotString xs

sudokuProblemString :: SudokuProblem -> String
sudokuProblemString s = concat [barString
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
                                                ,barString] where
      [a1,a2,a3,a4,a5,a6,a7,a8,a9] = [curry s y | y <- [1..9]]

type Weight = Int
type ActionProvider = SudokuProblem -> [SudokuAction]
type SudokuStrategy = (Int, ActionProvider)
