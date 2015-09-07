module TestTriangles where

import Triangles

countShapeOccurence :: Shape -> Int
countShapeOccurence s = length $ filter (==s) $ map (\(x,y,z) -> triangle x y z) [ (x,y,z) | x <- [3..5], y <- [3..5], z <- [3..5]]

testOccurences :: Bool
testOccurences = and [(countShapeOccurence Equilateral) == 3, 
                      (countShapeOccurence Isosceles) == 18,
                      (countShapeOccurence Rectangular) == 6]

testBaseCases :: Bool
testBaseCases = and [(triangle 3 4 5) == Rectangular,
                     (triangle 2 2 2) == Equilateral,
                     (triangle 20 20 5) == Isosceles,
                     (triangle 1 2 8) == NoTriangle,
                     (triangle 2 3 4) == Other]

 genEquilateral :: (Integer, Integer, Integer) -> IO ()
 genEquilateral = do 
 	x <- genEquilateral 20
 	return (x, x, x)

--testPost :: Int -> Int -> (Int -> Int -> Int -> Shape) -> Bool
--testPost = testR 1 100 triangles (\x y z s -> (x == y && y == z) => s == Equilateral,
--	                                          (x == y || y == z) => s == Isosceles,
--	                                          (x^2 + y^2 == z^2) => s == Rectangular,


-- |Source: Lecture 2, Jan van Eijck
getRandomInt :: Int -> IO Int
getRandomInt n = getStdRandom (randomR (1,n))
