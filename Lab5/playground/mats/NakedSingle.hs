module NakedSingle

where

import Domain
import Utils
import Control.Arrow

isNakedSingle :: Spot -> Bool
isNakedSingle (Unknown xs) = length xs == 1
isNakedSingle _ = False

lastValue :: Spot -> Int
lastValue (Unknown [x]) = x
lastValue _ = error "Not last value"

nakedSingle :: SudokuProblem -> [SudokuAction]
nakedSingle (sp) = map ((\(c,n) -> SetValue n c) . second lastValue) singles where
  singles :: [((Row,Column),Spot)]
  singles = filter (\(_,spot) -> not (spotSolved spot) && isNakedSingle spot) (allSpotsCor sp)
