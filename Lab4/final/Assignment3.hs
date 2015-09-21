module Assignment3 where

import SetOrd
import Test.QuickCheck
import Assignment2

intersectionSet :: (Ord a) => Set a -> Set a -> Set a
intersectionSet (Set []) _ = Set []
intersectionSet (Set xs) set2 = Set [ x | x <- xs , inSet x set2]


-- |unionSet is already defined in SetOrd.hs

differenceSet :: (Ord a) => Set a -> Set a -> Set a
differenceSet (Set []) _ = Set []
differenceSet (Set xs) set2 = Set [ x | x <- xs , not(inSet x set2)]


-- |Test functions with own generator
testR :: Int -> Int -> (Set Int -> Set Int -> Set Int)
                      -> (Set Int -> Set Int -> Set Int -> Bool) -> IO ()
testR k n f r = if k == n then print (show n ++ " tests passed")
                else do
                  xs <- genSetOwn
                  ys <- genSetOwn
                  if r xs ys (f xs ys) then
                    do print ("pass on: " ++ show xs ++ " " ++ show ys)
                       testR (k+1) n f r
                  else error ("failed test on: " ++ show xs ++ " " ++ show ys)


runTests :: IO ()
runTests = testR 1 100 intersectionSet (\p q r -> and
                [subSet r p                   -- | Test if the result is a subset of the original first argument
                , subSet r q                  -- | Test if the result is a subset of the original second argument
                , intersectionSet p r == r    -- | Test if the intersect of the result with the first argument is the result
                , intersectionSet q r == r    -- | Test if the intersect of the result with the second argument is the result
                , intersectionSet q p == r])  -- | Test if the intersect with the arguments swapped has the same outcome
