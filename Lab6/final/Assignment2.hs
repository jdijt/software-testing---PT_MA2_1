module Assignment2 where

import Lecture6
import System.TimeIt
import System.Random

speedTest :: IO ()
speedTest = do
	         input <- genrRandomInput 100
	         putStrLn "Implementation Assignment1 exM: "
	         main exM input
	         putStrLn "Original Implementation expM: "
	         main expM input

-- |Source: http://0xax.blogspot.nl/2013/08/get-function-execution-time-in-haskell.html
main :: (Integer -> Integer -> Integer -> Integer) -> [(Integer, Integer, Integer)] -> IO()
main f list = do
    putStrLn "Start"
    timeIt $ putStrLn ("Result: " ++ show (solveExponents f list))
    putStrLn "End"

solveExponents :: (Integer -> Integer -> Integer -> Integer) -> [(Integer, Integer, Integer)] -> [Integer]
solveExponents f = map (uncurryTriple f)

uncurryTriple :: (a -> a -> a -> a) -> (a, a, a) -> a
uncurryTriple f (x, y, z) = f x y z

genrRandomInput :: Integer -> IO [(Integer, Integer, Integer)]
genrRandomInput n | n == 0 = return []
	              | otherwise = do
	              		x <- getRandomInt 100
	              		y <- getRandomInt 100000
	              		z <- getRandomInt 100
	              		remainder <- genrRandomInput (n-1)
	              		return ( (x,y,z) : remainder)

-- |Source: Lecture 2
getRandomInt :: Integer -> IO Integer
getRandomInt n = getStdRandom (randomR (1,n))
