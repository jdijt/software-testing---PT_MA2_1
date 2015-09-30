module Puzzles

where
import Domain

def2puzzle :: [[Int]] -> [SudokuAction]
def2puzzle xss = map (\(r,c,n) -> SetValue n (r,c)) $ filter (\(_,_,n)-> n /=0) [(y, x, xss !! y !! x) | x <- [0..8], y <- [0..8]]

-- Easy
-- https://upload.wikimedia.org/wikipedia/commons/thumb/f/ff/Sudoku-by-L2G-20050714.svg/2000px-Sudoku-by-L2G-20050714.svg.png
puzzle1 :: [SudokuAction]
puzzle1 = [SetValue 5 (1,1)
           ,SetValue 3 (1,2)
           ,SetValue 7 (1,5)

           ,SetValue 6 (2,1)
           ,SetValue 1 (2,4)
           ,SetValue 9 (2,5)
           ,SetValue 5 (2,6)

           ,SetValue 9 (3,2)
           ,SetValue 8 (3,3)
           ,SetValue 6 (3,8)

           ,SetValue 8 (4,1)
           ,SetValue 6 (4,5)
           ,SetValue 3 (4,9)

           ,SetValue 4 (5,1)
           ,SetValue 8 (5,4)
           ,SetValue 3 (5,6)
           ,SetValue 1 (5,9)

           ,SetValue 7 (6,1)
           ,SetValue 2 (6,5)
           ,SetValue 6 (6,9)

           ,SetValue 6 (7,2)
           ,SetValue 2 (7,7)
           ,SetValue 8 (7,8)

           ,SetValue 4 (8,4)
           ,SetValue 1 (8,5)
           ,SetValue 9 (8,6)
           ,SetValue 5 (8,9)

           ,SetValue 8 (9,5)
           ,SetValue 7 (9,8)
           ,SetValue 9 (9,9)]

-- Medium
-- https://gratispuzzels.files.wordpress.com/2008/07/germ.jpg
puzzle2 :: [SudokuAction]
puzzle2 = [SetValue 4 (1,1)
          ,SetValue 5 (1,5)
          ,SetValue 3 (1,6)

          ,SetValue 2 (2,4)
          ,SetValue 9 (2,5)
          ,SetValue 4 (2,6)
          ,SetValue 7 (2,7)
          ,SetValue 3 (2,9)

          ,SetValue 3 (3,1)
          ,SetValue 7 (3,5)
          ,SetValue 5 (3,7)
          ,SetValue 9 (3,8)

          ,SetValue 7 (4,1)
          ,SetValue 8 (4,2)
          ,SetValue 1 (4,8)

          ,SetValue 4 (6,2)
          ,SetValue 2 (6,8)
          ,SetValue 5 (6,9)

          ,SetValue 2 (7,1)
          ,SetValue 8 (7,3)
          ,SetValue 1 (7,5)
          ,SetValue 7 (7,9)

          ,SetValue 9 (8,1)
          ,SetValue 1 (8,2)
          ,SetValue 7 (8,4)
          ,SetValue 6 (8,5)
          ,SetValue 2 (8,6)

          ,SetValue 8 (9,4)
          ,SetValue 3 (9,5)
          ,SetValue 2 (9,9)
          ]

-- Hard
-- https://gratispuzzels.files.wordpress.com/2008/07/ppz.jpg
puzzleDef3 :: [[Int]]
puzzleDef3 = [[0,0,6,0,5,8,0,0,0]
             ,[0,0,0,0,0,0,0,3,0]
             ,[0,8,2,0,0,0,0,4,9]
             ,[5,0,0,6,2,0,1,0,0]
             ,[0,0,4,0,0,0,6,0,0]
             ,[0,0,1,0,8,5,0,0,4]
             ,[2,9,0,0,0,0,7,6,0]
             ,[0,1,0,0,0,0,0,0,0]
             ,[0,0,0,1,7,0,3,0,0]]

puzzle3 :: [SudokuAction]
puzzle3 = def2puzzle puzzleDef3
