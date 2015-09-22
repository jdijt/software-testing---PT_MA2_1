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


-- |Helper fucntions for tests
setLength :: Set a -> Int
setLength (Set xs) = length xs

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

----------------------------
-- Intersection Tests     --
----------------------------

-- Own Tests
testIntersection :: IO ()
testIntersection = testR 1 100 intersectionSet (\p q r -> and
                    [subSet r p                   -- | Test if the result is a subset of the original first argument
                    , subSet r q                  -- | Test if the result is a subset of the original second argument
                    , intersectionSet p r == r    -- | Test if the intersect of the result with the first argument is the result
                    , intersectionSet q r == r    -- | Test if the intersect of the result with the second argument is the result
                    , intersectionSet q p == r])  -- | Test if the intersect with the arguments swapped has the same outcome

-- QuickCheck
prop_associativity :: Set Int -> Set Int -> Bool
prop_associativity xs ys = intersectionSet ys xs == intersectionSet xs ys

prop_subSetFirstArg :: Set Int -> Set Int -> Bool
prop_subSetFirstArg xs ys = subSet (intersectionSet xs ys) xs

prop_subSetSecondArg :: Set Int -> Set Int -> Bool
prop_subSetSecondArg = flip prop_subSetFirstArg

prop_intersectionWithResultSame :: Set Int -> Set Int -> Bool
prop_intersectionWithResultSame xs ys = result == intersectionSet xs result where
  result = intersectionSet xs ys

prop_intersectionWithResultSameSecondArg :: Set Int -> Set Int -> Bool
prop_intersectionWithResultSameSecondArg = flip prop_intersectionWithResultSame

prop_all :: Set Int -> Set Int -> Bool
prop_all x y = all (\f -> f x y) [prop_associativity
                                  ,prop_subSetFirstArg
                                  ,prop_subSetSecondArg
                                  ,prop_intersectionWithResultSame
                                  ,prop_intersectionWithResultSameSecondArg]

quickCheckIntersection :: IO ()
quickCheckIntersection = quickCheck prop_all


----------------------------
-- Union Tests -
----------------------------

-- Own Tests
testUnion :: IO ()
testUnion = testR 1 100 unionSet (\p q r -> and
                    [p `subSet` r                                 -- | Test if arg 1 is subset of the result
                    ,q `subSet` r                                 -- | Test if arg 2 is subset of the result
                    ,(r `differenceSet` p) `subSet` q             -- | Test is the difference between the result and arg 1 is a sub set of arg 2
                    ,(r `differenceSet` q) `subSet` r             -- | Test is the difference between the result and arg 2 is a sub set of arg 1
                    ,setLength r <=  setLength p + setLength q])  -- | Test if the length of the result is less then or equal to the sum of the lengths of the args
