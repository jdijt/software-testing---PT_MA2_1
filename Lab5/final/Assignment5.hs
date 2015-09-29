module Assignment5

where

import Assignment1


genNrcSudoku :: IO Node
genNrcSudoku = do
  [i] <- rsolveNs [emptyN]
  fill <- randomize (filledPositions (fst i))
  return (minimalize i fill)

showGenNrcSudoku :: IO ()
showGenNrcSudoku = do
  node <- genNrcSudoku
  showNode node
