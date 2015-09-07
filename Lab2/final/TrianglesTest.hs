module TrianglesTest where

import Triangles
import System.Random

-- | Base Cases
testBaseCases :: Bool
testBaseCases = and [(triangle 3 4 5) == Rectangular,
                     (triangle 2 2 2) == Equilateral,
                     (triangle 20 20 5) == Isosceles,
                     (triangle 1 2 8) == NoTriangle,
                     (triangle 2 3 4) == Other,
                     (triangle 0 2 2) == NoTriangle,
                     (triangle (-3) (-4) (-5)) == NoTriangle]

-- | Statistic based test
testOccurences :: Bool
testOccurences = and [(countShapeOccurence Equilateral) == 3,
                      (countShapeOccurence Isosceles) == 18,
                      (countShapeOccurence Rectangular) == 6]

countShapeOccurence :: Shape -> Int
countShapeOccurence s = length $ filter (==s) $ map (\(x,y,z) -> triangle x y z) [ (x,y,z) | x <- [3..5], y <- [3..5], z <- [3..5]]

-- | Generated triangular test cases
testEquilateral = testTriangle genEquilateral (==Equilateral)
testRectangular = testTriangle genRectangular (==Rectangular)
testChangeRectangular = testTriangle (changeRandomLeg genRectangular) (/=Rectangular)
testChangingOneLeg = testTriangle (changeRandomLeg genEquilateral) (\s -> s == Isosceles || s == NoTriangle)


-- | Test Method
testTriangle :: IO (Integer, Integer, Integer)
         -> (Shape -> Bool)
         -> IO()
testTriangle = testR 1 100 triangle

testR :: Integer
         -> Integer
         -> (Integer -> Integer -> Integer -> Shape)
         -> IO (Integer, Integer, Integer)
         -> (Shape -> Bool)
         -> IO()
testR k n f g r = if k == n then print (show n ++ " tests passed")
                else do
                    (x, y, z) <- g
                    if r (f x y z) then
                        do print ("pass on: " ++ show (x, y, z))
                           testR (k+1) n f g r
                    else error ("failed test on: " ++ show (x, y, z))

-- | Generate triangles

changeRandomLeg :: IO (Integer, Integer, Integer) -> IO (Integer, Integer, Integer)
changeRandomLeg g = do
    (x, y, z) <- g
    r <- getRandomInt 1 20
    d <- randomFlip r
    p <- getRandomInt 1 3
    if (p == 1) then
        return (x+d, y, z)
    else if (p == 2) then
        return (x, y+d, z)
    else
        return (x, y, z+d)

genRectangular :: IO (Integer, Integer, Integer)
genRectangular = do
    n <- getRandomInt 0 125
    return (getPythagoras !! (fromInteger n))

getPythagoras :: [(Integer, Integer, Integer)]
getPythagoras = [(x, y, z) | x <- [1..100], y <- [1..100], z <- [1..141], x^2 + y^2 == z^2]

genEquilateral :: IO (Integer, Integer, Integer)
genEquilateral = do
 	x <- getRandomInt 1 20
 	return (x, x, x)


-- |Source: Lecture 2, Jan van Eijck
randomFlip :: Integer -> IO Integer
randomFlip x = do
   b <- getRandomInt 0 1
   if b==0 then return x else return (-x)

getRandomInt :: Integer -> Integer -> IO Integer
getRandomInt n m = getStdRandom (randomR (n, m))
