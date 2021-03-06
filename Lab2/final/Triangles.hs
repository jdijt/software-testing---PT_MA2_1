module Triangles where

import Data.List

data Shape = NoTriangle | Equilateral
           | Isosceles  | Rectangular | Other deriving (Eq,Show)


-- |Specifies the type of triangle
-- |Preconditions: Takes three integers
triangle :: Integer -> Integer -> Integer -> Shape
triangle a b c | x + y <= z = NoTriangle
               | x == y && y == z = Equilateral
               | x == y || y == z = Isosceles
               | x^2 + y^2 == z^2 = Rectangular
               | otherwise = Other
               where
                 [x,y,z] = sort [a,b,c]
