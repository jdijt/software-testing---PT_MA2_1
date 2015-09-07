module Triangles where 

import Data.List

data Shape = NoTriangle | Equilateral 
           | Isosceles  | Rectangular | Other deriving (Eq,Show)


-- |Specifies the type of triangle
-- |Preconditions: Takes three positive nonzero integers 
triangle :: Integer -> Integer -> Integer -> Shape
triangle a b c | x + y < z = NoTriangle 
               | x == y && y == z = Equilateral
               | x == y || y == z = Isosceles
               | x^2 + y^2 == z^2 = Rectangular
               | otherwise = Other
               where 
                 z = maximum [a,b,c]
                 x = minimum [a,b,c]
                 y = minimum (delete x [a,b,c])
