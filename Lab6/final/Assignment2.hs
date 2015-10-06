module Assignment2 where 

import Assignment1
import Lecture6 hiding (exM)
import System.TimeIt
import Control.Monad
import System.Random

speedTest :: IO [(Integer, Integer, Integer)] -> IO ()
speedTest list = do
	         l <- list
	         putStrLn $ show l
	         putStrLn "Own Implementation exM: "
	         main exM l
	         putStrLn "Original Implementation expM: "
	         main expM l

-- |Source: http://0xax.blogspot.nl/2013/08/
--          get-function-execution-time-in-haskell.html
main :: (Integer -> Integer -> Integer -> Integer) -> [(Integer, Integer, Integer)] -> IO()
main f list = do
    putStrLn "Start"
    timeIt $ putStrLn ("Result: " ++ show (solveExponents f list))
    putStrLn "End"

solveExponents :: (Integer -> Integer -> Integer -> Integer) -> [(Integer, Integer, Integer)] -> [Integer]
solveExponents f xs = map (uncurryTriple f) xs 
               

uncurryTriple :: (Integer -> Integer -> Integer -> Integer) -> (Integer, Integer, Integer) -> Integer
uncurryTriple f (x, y, z) = f x y z


genrRandomInput :: Integer -> IO [(Integer, Integer, Integer)]
genrRandomInput n | n == 0 = return []
	              | otherwise = do 
	              		x <- getRandomInt (100)
	              		y <- getRandomInt (10^5)
	              		z <- getRandomInt (100)
	              		remainder <- genrRandomInput (n-1)
	              		return ( (x,y,z) : remainder)

-- |Source: Lecture 2
getRandomInt :: Integer -> IO Integer
getRandomInt n = getStdRandom (randomR (1,n))

