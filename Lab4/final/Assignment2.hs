module Assignment2 where 

import SetOrd
import System.Random
import Data.List
import Test.QuickCheck

-- |Naive generator

-- |Source: Lecture 2
getRandomInt :: Int -> IO Int
getRandomInt n = getStdRandom (randomR (0,n)) 

-- |Source: Lecture 2
randomFlip :: Int -> IO Int
randomFlip x = do 
   b <- getRandomInt 1
   if b == 0 then return x else return (-x)

getIntL :: Int -> IO [Int]
getIntL 0 = return []
getIntL n = do
	x <- getRandomInt 100
	y <- randomFlip x
	ys <- getIntL (n-1)
	return (y:ys) 

genSetNaive :: IO (Set Int)
genSetNaive = do
	n <- getRandomInt 100
	xs <- getIntL n
	return (Set (sort $ nub xs))

-- |Generator for QuickCheck 

genSet :: Gen (Set Int)
genSet = do
	list <- orderedList
	return (Set (nub list)) 


