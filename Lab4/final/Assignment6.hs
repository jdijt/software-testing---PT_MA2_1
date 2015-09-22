module Assignment6 where

import Lecture4
import Data.List
import Data.Function

-- Pre: Some ordered list of pairs
-- Post: 
--  - Ordered set of pairs
--  - No duplicates
--  - result is a transitively closed.
trClos :: Ord a => Rel a -> Rel a
trClos r = sort $ fix (\f x -> if x == trIteration r x then x else f ( trIteration r x) ) r
    where
    trIteration :: Ord a => Rel a -> Rel a -> Rel a
    trIteration b x = nub $ x ++ (x @@ b)
