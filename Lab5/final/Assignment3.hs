module Assignment3

where

import Lecture5
import Test.QuickCheck
testR :: Int -> Int -> (Node -> [(Row,Column)] -> Node)
                    -> (Node -> [(Row,Column)] -> Node -> Bool) -> IO ()
testR k n f r = if k == n then print (show n ++ " tests passed")
               else do
                 [i] <- rsolveNs [emptyN]
                 fill <- randomize (filledPositions (fst i))
                 let res = (f i fill)
                 if r i fill res then
                   do print "pass on: "
                      showNode res
                      testR (k+1) n f r
                 else error "failed test on: "


genMinimalizedNode :: IO (Gen Node)
genMinimalizedNode = do
  i <- rsolveNs [emptyN]
  let j = map (\q -> minimalize q (filledPositions (fst q))) i
  return (elements j)

testMinimalize :: IO ()
testMinimalize = testR 1 100 minimalize (\_ _ o -> all (not.uniqueSol.eraseN o) (filledPositions (fst o)) && uniqueSol o)
















---
