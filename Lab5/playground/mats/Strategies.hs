module Strategies

where

import Domain
import NakedSingle
import HiddenSingle

strategies :: [SudokuStrategy]
strategies = [(1, nakedSingle), (5, hiddenSingle)]
