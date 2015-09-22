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
                    [subSet r p                   -- | Test if the result is a subset of arg 1
                    , subSet r q                  -- | Test if the result is a subset of arg 2
                    , intersectionSet p r == r    -- | Test if the intersect of the result with arg 1 is equal to the result
                    , intersectionSet q r == r    -- | Test if the intersect of the result with arg 2 is equal to the result
                    , intersectionSet q p == r])  -- | Test if the intersect with the arguments flipped has the same result

-- QuickCheck
prop_intersect_subSetArg1 :: Set Int -> Set Int -> Bool
prop_intersect_subSetArg1 p q = subSet r p where r = intersectionSet p q

prop_intersect_subSetArg2 :: Set Int -> Set Int -> Bool
prop_intersect_subSetArg2 = flip prop_intersect_subSetArg1

prop_intersect_sameResultArg1 :: Set Int -> Set Int -> Bool
prop_intersect_sameResultArg1 p q = r == intersectionSet p r where
  r = intersectionSet p q

prop_intersect_sameResultArg2 :: Set Int -> Set Int -> Bool
prop_intersect_sameResultArg2 = flip prop_intersect_sameResultArg1

prop_intersect_associativity :: Set Int -> Set Int -> Bool
prop_intersect_associativity p q = r == intersectionSet q p where r = intersectionSet p q


prop_intersect_all :: Set Int -> Set Int -> Bool
prop_intersect_all x y = all (\f -> f x y) [prop_intersect_subSetArg1
                                            ,prop_intersect_subSetArg2
                                            ,prop_intersect_sameResultArg1
                                            ,prop_intersect_sameResultArg2
                                            ,prop_intersect_associativity]

quickCheckIntersection :: IO ()
quickCheckIntersection = quickCheck prop_intersect_all


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

-- QuickCheck
prop_union_subsetArg1 :: Set Int -> Set Int -> Bool
prop_union_subsetArg1 p q = p `subSet` r where r = unionSet p q

prop_union_subSetArg2 :: Set Int -> Set Int -> Bool
prop_union_subSetArg2 = flip prop_union_subsetArg1

prop_union_differenceIsArg2 :: Set Int -> Set Int -> Bool
prop_union_differenceIsArg2 p q = (r `differenceSet` p) `subSet` q where r = unionSet p q

prop_union_differenceIsArg1 :: Set Int -> Set Int -> Bool
prop_union_differenceIsArg1 = flip prop_union_differenceIsArg2

prop_union_length :: Set Int -> Set Int -> Bool
prop_union_length p q = setLength r <=  setLength p + setLength q where r = unionSet p q

prop_union_all :: Set Int -> Set Int -> Bool
prop_union_all x y = all (\f -> f x y) [prop_union_subsetArg1
                                  ,prop_union_subSetArg2
                                  ,prop_union_differenceIsArg2
                                  ,prop_union_differenceIsArg1
                                  ,prop_union_length]

quickCheckUnion :: IO ()
quickCheckUnion = quickCheck prop_union_all

----------------------------
-- Difference Tests -
----------------------------

-- Own Tests
testDifference :: IO ()
testDifference = testR 1 100 differenceSet (\p q r -> and
                    [r `subSet` p                                           -- | Test if the result is a sub set of arg 1
                    ,q `differenceSet`r == q                                -- | Test if the result does not overlap with arg 2
                    ,r `unionSet` q == p `unionSet` q                       -- | Test if the union of the result and arg 2 covers the whole space
                    ,isEmpty (r `intersectionSet` (q `differenceSet` p))])  -- | Test if the result has no overlap when flipping the arguments

-- QuickCheck
prop_diff_subsetArg1 :: Set Int -> Set Int -> Bool
prop_diff_subsetArg1 p q = p `subSet` r where r = p `differenceSet` q

prop_diff_noOverlapArg2 :: Set Int -> Set Int -> Bool
prop_diff_noOverlapArg2 p q = q `differenceSet`r == q where r = p `differenceSet` q

prop_diff_spanResult :: Set Int -> Set Int -> Bool
prop_diff_spanResult p q = r `unionSet` q == p `unionSet` q where r = p `differenceSet` q

prop_diff_noAssociativity :: Set Int -> Set Int -> Bool
prop_diff_noAssociativity p q = isEmpty (r `intersectionSet` (q `differenceSet` p)) where r = p `differenceSet` q

prop_diff_all :: Set Int -> Set Int -> Bool
prop_diff_all x y = all (\f -> f x y) [prop_union_subsetArg1
                                  ,prop_union_subSetArg2
                                  ,prop_union_differenceIsArg2
                                  ,prop_union_differenceIsArg1
                                  ,prop_union_length]

quickCheckDiff :: IO ()
quickCheckDiff = quickCheck prop_diff_all
