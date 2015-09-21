module Assignment5 where

import Data.List

type Rel a = [(a,a)]

-- For now assuming the following:
-- Pre: Some list of pairs
-- Post:
--  - Ordered (natural ordering) set of pairs
--  - No duplicates
--  - result is a symmetric Relation
symClos :: Ord a => Rel a -> Rel a
symClos = nub.sort.foldr (\(x,y) r -> (x,y):(y,x):r) [] 
