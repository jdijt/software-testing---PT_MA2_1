module NakedPairs

where

import Domain
import Utils
import Data.List

nakedPairs :: SudokuProblem -> [SudokuAction]
nakedPairs sp = meaningfullActions sp (concatMap actionsPerGroup grouped)  where
  nakedPairCandidates = filter (\(_, Unknown xs) -> length xs == 2) $ filter (not.spotSolved.snd) (allSpotsCor sp)
  grouped = groupBy sameUnknowns (sortBy unkownSort nakedPairCandidates)

actionsPerGroup :: [(Coordinate, Spot)] -> [([Int], [Coordinate])]
actionsPerGroup [] = []
actionsPerGroup (x:xs) = result ++ actionsPerGroup xs where
  Unknown us = snd x
  xrel = relatedSpots (fst x)
  result = [ (us, xrel `intersect` relatedSpots (fst y)) | y <- xs, fst y `elem` xrel]

meaningfullActions :: SudokuProblem -> [([Int], [Coordinate])] -> [SudokuAction]
meaningfullActions _ [] = []
meaningfullActions sp (x:xs) = if null (fst meaningFull) then meaningfullActions sp xs else asScrapValues meaningFull : meaningfullActions sp xs where
  meaningFull :: ([Int], [Coordinate])
  meaningFull = toMeaningfull x
  toMeaningfull :: ([Int], [Coordinate]) -> ([Int], [Coordinate])
  toMeaningfull (is,cs) = (filter (\i -> any (\c -> spotHasPossibility i (c,sp c)) cs) is, cs)
  asScrapValues :: ([Int], [Coordinate]) -> SudokuAction
  asScrapValues (is, cs) = ScrapValues is cs

sameUnknowns :: (Coordinate, Spot) -> (Coordinate,Spot) -> Bool
sameUnknowns (_,Known _) _ = False
sameUnknowns _ (_,Known _) = False
sameUnknowns (_,Unknown xs) (_,Unknown ys) = xs == ys

unkownSort :: (Coordinate, Spot) -> (Coordinate,Spot) -> Ordering
unkownSort (_,Unknown xs) (_,Unknown ys) = compare xs ys
