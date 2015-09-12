module TrianglesTest where

import Triangles
import Data.List
import System.Random

-- | Base Cases
testBaseCases :: Bool
testBaseCases = and [triangle 3 4 5 == Rectangular,
                     triangle 2 2 2 == Equilateral,
                     triangle 20 20 5 == Isosceles,
                     triangle 1 2 8 == NoTriangle,
                     triangle 2 3 4 == Other,
                     triangle 0 2 2 == NoTriangle,
                     triangle (-3) (-4) (-5) == NoTriangle]

-- | Statistics over a certain domain
testOccurrences :: Bool
testOccurrences = and [countShapeOccurrence Equilateral == 3,
                      countShapeOccurrence Isosceles == 18,
                      countShapeOccurrence Rectangular == 6]

countShapeOccurrence :: Shape -> Int
countShapeOccurrence s = length $ filter (==s) $ map (\(x,y,z) -> triangle x y z) [ (x,y,z) | x <- [3..5], y <- [3..5], z <- [3..5]]

-- | Property based tests
testEquilateral = testTriangle genEquilateral (\_ _ _ s -> s==Equilateral)
testRectangular = testTriangle genRectangular (\_ _ _ s -> s==Rectangular)
testChangeRectangular = testTriangle (changeRandomLeg genRectangular) (\_ _ _ s -> s /=Rectangular)
testChangeEquilateral = testTriangle (changeRandomLeg genEquilateral) (\_ _ _ s -> s == Isosceles || s == NoTriangle)
testPermutations = testTriangle (changeRandomLeg genEquilateral) (\x y z s -> all (==s) $ map (\(x, y, z) -> triangle x y z) $ permutateTriple (x, y, z))


-- | Test Method
testTriangle :: IO (Integer, Integer, Integer)
         -> (Integer -> Integer -> Integer -> Shape -> Bool)
         -> IO()
testTriangle = testR 1 100 triangle

testR :: Integer
         -> Integer
         -> (Integer -> Integer -> Integer -> Shape)
         -> IO (Integer, Integer, Integer)
         -> (Integer -> Integer -> Integer -> Shape -> Bool)
         -> IO()
testR k n f g r = if k == n then print (show n ++ " tests passed")
                else do
                    (x, y, z) <- g
                    if r x y z (f x y z) then
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
    if p == 1 then
        return (x+d, y, z)
    else if p == 2 then
        return (x, y+d, z)
    else
        return (x, y, z+d)

permutateTriple :: (Integer, Integer, Integer) -> [(Integer, Integer, Integer)]
permutateTriple (x, y, z) = [(a, b, c) | [a, b, c] <- permutations [x, y, z]]

genRectangular :: IO (Integer, Integer, Integer)
genRectangular = do
    n <- getRandomInt 0 125
    return (getPythagoras !! fromInteger n)

getPythagoras :: [(Integer, Integer, Integer)]
getPythagoras = [(x, y, z) | x <- [1..100], y <- [1..100], z <- [1..141], x^2 + y^2 == z^2]

genRandomTriangle :: IO (Integer, Integer, Integer)
genRandomTriangle = do
    x <- getRandomInt 1 20
    y <- getRandomInt 1 20
    z <- getRandomInt 1 20
    return (x, y, z)

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
