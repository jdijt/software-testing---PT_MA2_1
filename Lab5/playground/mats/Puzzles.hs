module Puzzles

where
import Domain

def2puzzle :: [[Int]] -> [SudokuAction]
def2puzzle xss = map (\(r,c,n) -> SetValue n (r,c)) $ filter (\(_,_,n)-> n /=0) [(y + 1, x +1, xss !! y !! x) | x <- [0..8], y <- [0..8]]

-- Easy
-- https://upload.wikimedia.org/wikipedia/commons/thumb/f/ff/Sudoku-by-L2G-20050714.svg/2000px-Sudoku-by-L2G-20050714.svg.png
puzzle1 :: [SudokuAction]
puzzle1 = def2puzzle [[5,3,0,0,7,0,0,0,0]
                     ,[6,0,0,1,9,5,0,0,0]
                     ,[0,9,8,0,0,0,0,6,0]
                     ,[8,0,0,0,6,0,0,0,3]
                     ,[4,0,0,8,0,3,0,0,1]
                     ,[7,0,0,0,2,0,0,0,6]
                     ,[0,6,0,0,0,0,2,8,0]
                     ,[0,0,0,4,1,9,0,0,5]
                     ,[0,0,0,0,8,0,0,7,9]]

-- Medium
-- https://gratispuzzels.files.wordpress.com/2008/07/germ.jpg
puzzle2 :: [SudokuAction]
puzzle2 = def2puzzle [[4,0,0,0,5,3,0,0,0]
                     ,[0,0,0,2,9,4,0,7,3]
                     ,[3,0,0,0,7,0,5,0,9]
                     ,[7,8,0,0,0,0,0,1,0]
                     ,[0,0,0,0,0,0,0,0,0]
                     ,[0,4,0,0,0,0,0,2,5]
                     ,[2,0,8,0,1,0,0,0,7]
                     ,[9,1,0,7,6,2,0,0,0]
                     ,[0,0,0,8,3,0,0,0,2]]

-- Hard
-- https://gratispuzzels.files.wordpress.com/2008/07/ppz.jpg
puzzle3 :: [SudokuAction]
puzzle3 = def2puzzle [[0,0,6,0,5,8,0,0,0]
                     ,[0,0,0,0,0,0,0,3,0]
                     ,[0,8,2,0,0,0,0,4,9]
                     ,[5,0,0,6,2,0,1,0,0]
                     ,[0,0,4,0,0,0,6,0,0]
                     ,[0,0,1,0,8,5,0,0,4]
                     ,[2,9,0,0,0,0,7,6,0]
                     ,[0,1,0,0,0,0,0,0,0]
                     ,[0,0,0,1,7,0,3,0,0]]
