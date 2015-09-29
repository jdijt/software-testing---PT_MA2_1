module Assignment4
where

import Lecture5

possibleBlocks :: [([Row],[Column])]
possibleBlocks = [ (x,y) | x <- blocks, y <- blocks]

minimalizeBlocks :: Node -> [[(Row,Column)]] -> Node
minimalizeBlocks n [] = n
minimalizeBlocks n (x:xs) | uniqueSol n' = minimalizeBlocks n' xs
                          | otherwise    = minimalizeBlocks n  xs
    where n' = foldl eraseN n x

genProblemEmptyBlocks :: Node -> IO Node
genProblemEmptyBlocks n = do
                            -- First take out as many blocks as possible
                            rblocks <- randomize possibleBlocks
                            let blocks' = map (\(x,y) -> [(a,b)| a <- x, b <-y ]) rblocks
                            let n' = minimalizeBlocks n blocks'
                            -- Then try to minimalize the remainder
                            i <- randomize (filledPositions (fst n'))
                            return (minimalize n' i)

mainEmptyBlocks :: IO ()
mainEmptyBlocks = do
                    [r] <- rsolveNs [emptyN]
                    showNode r
                    s  <- genProblemEmptyBlocks r
                    showNode s