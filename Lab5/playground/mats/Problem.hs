module Problem
where

import Data.List

-- Stategies
import NakedSingle
import HiddenSingle

import Domain
import Utils

emptyProblem :: SudokuProblem
emptyProblem = SP [[Unknown [1..9] | _ <- [1..9]] | _ <- [1..9]]

solveValue :: Int -> Int -> Int -> SudokuProblem -> SudokuProblem
solveValue n x y (SP sp) = SP (replaceAtIndex y newY sp) where
  newY = replaceAtIndex x (Known n) (sp !! y)

relatedSpots :: Int -> Int -> [(Int, Int)]
relatedSpots x y = nub ([(x,a) | a <- [0..8], a /= y] ++ [(a,y) | a <- [0..8], a /= x] ++
  [ (a,b) | let _x = div x 3 * 3, let _y = div y 3 * 3, a <- [_x.._x+2], b <- [_y.._y+2], a /= x && b /= y])

removePossibilitySpot :: Int -> Spot -> Spot
removePossibilitySpot n (Unknown k) = Unknown (delete n k)
removePossibilitySpot _ sp = sp


removePossibility :: Int -> SudokuProblem -> (Int, Int) -> SudokuProblem
removePossibility n (SP sp) (x,y) = if isSolved x y (SP sp) then SP sp else SP (replaceAtIndex y newY sp) where
  newY = replaceAtIndex x (removePossibilitySpot n ((sp !! y) !! x)) (sp !! y)

applyAction :: SudokuAction -> SudokuProblem -> (SudokuProblem,[SudokuAction])
applyAction (SetValue n x y) sp = if hasValue n x y sp then (sp,[]) else  (solveValue n x y sp, [ScrapValue n x y])
applyAction (ScrapValue n x y) sp = (foldl (removePossibility n) sp related, [])  where
  related = relatedSpots x y

applyActions :: (SudokuProblem, [SudokuAction]) -> (SudokuProblem,[SudokuAction])
applyActions (p,[]) = (p, [])
applyActions (p,x:xs) = applyActions (np, na ++ xs) where
  (np, na) = applyAction x p

example1 :: [SudokuAction]
example1 = [SetValue 1 1 0
           ,SetValue 2 2 0
           ,SetValue 9 3 1
           ,SetValue 9 6 2
           ,SetValue 5 1 8
           ,SetValue 5 2 5
           ,SetValue 3 0 2]

strategies :: [SudokuStrategy]
strategies = [(1, nakedSingle), (3, hiddenSingle)]

handle :: (SudokuProblem, [SudokuAction]) -> (SudokuProblem, [SudokuAction])
handle (p,[]) = if null next then (p,[]) else handle (p, snd (head next)) where
  next = filter (\(_,a) -> not (null a)) $ map (\(l,provider) -> (l, provider p)) strategies
handle (p,xs) = handle (applyActions (p,xs))

foo = do
  let (SP sp,_) = handle (emptyProblem, example1)
  putStrLn ("Solved: " ++ show (all spotSolved (concat sp)))
  putStr (sudokuProblemString (SP sp))
