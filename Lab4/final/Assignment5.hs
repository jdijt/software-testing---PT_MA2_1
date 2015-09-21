module Assignment5 where

import Lecture4
import Data.List

-- For now assuming the following:
-- Pre: Some list of pairs
-- Post:
--  - Ordered (natural ordering) set of pairs
--  - No duplicates
--  - result is a symmetric Relation
symClos :: Ord a => Rel a -> Rel a
symClos = nub.sort.foldr (\(x,y) r -> (x,y):(y,x):r) [] 
