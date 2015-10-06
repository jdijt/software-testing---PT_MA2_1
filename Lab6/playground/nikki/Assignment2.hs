module Assignment2 where 

import Assignment1
import System.TimeIt
import Control.Monad
import System.Random


speedTest = do
	         let randomList = genrRandomInput 5
	         main exM' randomList
	         main exM randomList


-- |Source: http://0xax.blogspot.nl/2013/08/
--          get-function-execution-time-in-haskell.html
main :: (Integer -> Integer -> Integer -> Integer) -> [(IO Integer, IO Integer, IO Integer)] -> IO()
main f list = do
    putStrLn "Start"
    result <- solveExponents f list
    timeIt $ putStrLn ("Result: " ++ show result)
    putStrLn "End"

solveExponents :: (Integer -> Integer -> Integer -> Integer) -> [(IO Integer, IO Integer, IO Integer)] -> IO [Integer]
solveExponents f xs = mapM (solveExponent f) xs

solveExponent :: (Integer -> Integer -> Integer -> Integer) -> (IO Integer, IO Integer, IO Integer) -> IO Integer
solveExponent f (x,y,z) = 
				       do
	                     result <- liftM3 f x y z
	             	     return (result)


--uncurryTriple :: (a -> b -> c -> d) -> (a, b, c) -> d
--uncurryTriple f (a, b, c) = f a b c 

genrRandomInput :: Integer -> [(IO Integer, IO Integer, IO Integer)]
genrRandomInput n | n == 0 = []
	                | otherwise = (getRandomInt (10^1), getRandomInt (10^100), getRandomInt (10^5)) 
	                              : genrRandomInput (n-1)



-- |Source: Lecture 2
getRandomInt :: Integer -> IO Integer
getRandomInt n = getStdRandom (randomR (0,n))

