module Assignment4

where

import Lecture5

possibleBlocks :: [([Row],[Column])]
possibleBlocks = [ (x,y) | x <- blocks, y <- blocks]

minimalizeBlocks :: Node -> [[(Row,Column)]] -> Int -> Node
minimalizeBlocks n _ 0 = n
minimalizeBlocks n [] max = n
minimalizeBlocks n (x:xs) max | uniqueSol n' = minimalizeBlocks n' xs (max - 1)
                              | otherwise    = minimalizeBlocks n  xs max
    where n' = foldl eraseN n x

genProblemEmptyBlocks :: Node -> Int -> IO Node
genProblemEmptyBlocks n maxEmptyBlocks = do
                            -- First take out as many blocks as possible
                            rblocks <- randomize possibleBlocks
                            let blocks' = map (\(x,y) -> [(a,b)| a <- x, b <-y ]) rblocks
                            let n' = minimalizeBlocks n blocks' maxEmptyBlocks
                            -- Then try to minimalize the remainder
                            i <- randomize (filledPositions (fst n'))
                            return (minimalize n' i)

mainEmptyBlocks :: Int -> IO ()
mainEmptyBlocks maxEmptyBlocks = do
                    [r] <- rsolveNs [emptyN]
                    showNode r
                    s  <- genProblemEmptyBlocks r maxEmptyBlocks
                    showNode s

------------------------------------------------------
--      Tests
------------------------------------------------------

testR :: Int -> Int -> (Node -> Node -> Bool) -> IO ()
testR k n r = if k == n then print (show n ++ " tests passed")
               else do
                 [i] <- rsolveNs [emptyN]
                 res <- genProblemEmptyBlocks i 3
                 if r i res then
                   do print "pass on: "
                      showNode res
                      testR (k+1) n r
                 else error "failed test"


hasSolution :: Node -> Node -> Bool
hasSolution x y =  sud2grid (fst (head (solveNs [x]))) == sud2grid (fst y)

testMinimalizeBlocks :: IO ()
testMinimalizeBlocks = testR 1 100 (\i o -> all (not.uniqueSol.eraseN o) (filledPositions (fst o)) && uniqueSol o && hasSolution o i)
