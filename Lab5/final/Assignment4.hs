module Assignment4
where

import Lecture5

possibleBoxes :: [([Row],[Column])]
possibleBoxes = [ (x,y) | x <- blocks, y <- blocks]

generateEmptyBoxes :: Int -> IO ()
generateEmptyBoxes n = do
  [r] <- rsolveNs [emptyN]
  s <- randomize possibleBoxes
  let t = take n s
  let u = concatMap (\(x,y) -> [(a,b)| a <- x, b <-y ]) t
  let v = foldl eraseN r u
  showNode v
