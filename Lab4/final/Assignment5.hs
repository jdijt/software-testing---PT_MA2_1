module Assignment5 where

import Lecture4
import Data.List

-- The total amount of time spent by two persons on this lab exercise was 2 hours

-- Pre: Some list of pairs
-- Post:
--  - Ordered (natural ordering) set of pairs
--  - No duplicates
--  - result is a symmetric Relation
symClos :: Ord a => Rel a -> Rel a
symClos = nub.sort.foldr (\(x,y) r -> (x,y):(y,x):r) [] 
