module NakedSingle

where

import Domain
import Utils

isNakedSingle :: Spot -> Bool
isNakedSingle (Unknown xs) = length xs == 1
isNakedSingle _ = False

lastValue :: Spot -> Int
lastValue (Unknown [x]) = x
lastValue _ = error "Not last value"

nakedSingle :: SudokuProblem -> [SudokuAction]
nakedSingle (SP ps) = map (\(z,x,y) -> SetValue z x y )  [ (z,x,y) | x <- [0..8], y <- [0..8], let spot = (ps !! y) !! x, not (spotSolved spot) && isNakedSingle spot, let z = lastValue spot]
