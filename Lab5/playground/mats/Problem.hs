module Problem
where

import Data.List

import Strategies
import Puzzles
import Domain
import Utils

removePossibilitySpot :: Int -> Spot -> Spot
removePossibilitySpot n (Unknown k) = Unknown (delete n k)
removePossibilitySpot _ sp = sp

removePossibility :: Int -> SudokuProblem -> (Int, Int) -> SudokuProblem
removePossibility n prob c = if spotSolved (prob c) then prob else update prob (c, removePossibilitySpot n (prob c))

applyAction :: SudokuAction -> SudokuProblem -> (SudokuProblem,[SudokuAction])
applyAction (SetValue n c) prob = if spotHasValue n (prob c) then (prob,[]) else (update prob (c,Known n), [ScrapValue n c])
applyAction (ScrapValues ns cs) prob = (foldl (\b n -> foldl (removePossibility n) b cs) prob ns, [])
applyAction (ScrapValue n c) prob = (foldl (removePossibility n) prob related, [])  where
  related = relatedSpots c

applyActions :: (SudokuProblem, [SudokuAction], Difficulty) -> (SudokuProblem,[SudokuAction], Difficulty)
applyActions (p,[],l) = (p, [], l)
applyActions (p,x:xs,l) = applyActions (np, na ++ xs, l) where
  (np, na) = applyAction x p


handle :: (SudokuProblem, [SudokuAction], Difficulty) -> (SudokuProblem, [SudokuAction], Difficulty)
handle (p,[],diff) = if null next then (p,[],diff) else handle (p, snd (head next),diff + fst (head next) * length (snd (head next)) ) where
  next = filter (\(_,a) -> not (null a)) $ map (\(l,provider) -> (l, provider p)) strategies
handle (p,xs,l) = handle (applyActions (p,xs, l))


(temp,_,_) = applyActions (emptyProblem,puzzle3,0)

doPuzzle :: [SudokuAction] -> IO ()
doPuzzle acts = do
  let (prob,_,probLevel) = handle (emptyProblem, acts, 0)
  putStrLn ("Solved: " ++ show (all spotSolved (allSpots prob)))
  putStrLn ("Level: " ++ show probLevel)
  putStr (sudokuProblemString prob)
