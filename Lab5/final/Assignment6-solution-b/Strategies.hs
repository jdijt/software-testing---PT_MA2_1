module Strategies

where

import Domain
import NakedSingle
import HiddenSingle
import NakedPairs

strategies :: [SudokuStrategy]
strategies = [(1, nakedSingle), (3, hiddenSingle), (10, nakedPairs)]
