module DerangementsTest where

import Permutations
import Derangements
import Data.List
import System.Random

----------------------
-- Testable properties
----------------------
noMatchingIndices :: Eq a => [a] -> [a] -> Bool
noMatchingIndices xs ys = all (\(x,y) -> x /= y) (zip xs ys)

--isPermutation, imported from Permutations.hs

----------------------
-- Tests
----------------------

--TestBasic
testBasic :: Bool
testBasic = and [(isDerangement ([]::[Int]) []) == True,
				(isDerangement [1] []) == False,
				(isDerangement [] [1]) == False,
				(isDerangement [1] [1]) == False,
				(isDerangement [1,2] [2,1]) == True,
				(isDerangement [1] [2]) == False,
				(isDerangement [1,2,3] [2,1,3]) == False]

-- 'Random based tests'
testRandom :: IO ()
testRandom = testProperty isDerangement (isPermutation .&&. noMatchingIndices)

-- 'Happy tests'
testDerangements :: IO()
testDerangements = do
					sourceList <- genIntList 6 10
					let derangements = deran sourceList
					if (all (isDerangement sourceList) derangements) then do
						print ("pass on all derangements of : " ++ show sourceList)
					else error ("failed test on one of the derangements of: " ++ show sourceList)

----------------------
-- Helpers
----------------------
-- Function composition for properties of type a -> a -> Bool
(.&&.) :: (a -> a -> Bool) -> (a -> a -> Bool) -> a -> a -> Bool
p .&&. q = (\x y -> p x y && q x y)

-- Additional logic notation
infix 1 ==>
(==>) :: Bool -> Bool -> Bool
p ==> q = (not p) || q

----------------------
-- Test methods
----------------------
getRandomInt :: Int -> IO Int
getRandomInt n = getStdRandom (randomR (0,n))

genIntList :: Int -> Int -> IO [Int]
genIntList numberOfElements maxValue = do
	n <- getRandomInt numberOfElements
	getIntL [0..maxValue] n

pickInt :: [Int] -> IO Int
pickInt is = do
	x <- getRandomInt (length is - 1)
	return (is !! x)

--Generate random list without duplicates by picking values from the provided list.
getIntL :: [Int] -> Int -> IO [Int]
getIntL _ 0 = return []
getIntL is n = do
	x <- pickInt is
	xs <- getIntL (delete x is) (n-1)
	return (x:xs)

testR :: Int -> Int -> ([Int] -> [Int] -> Bool) -> ([Int] -> [Int] -> Bool -> Bool) -> IO ()
testR k n f r =
			if k == n then print (show n ++ " tests passed")
            else do
				xs <- genIntList 2 2
				ys <- genIntList 2 2
				if r xs ys (f xs ys) then do
					print ("pass on: " ++ show xs ++ " " ++ show ys)
					testR (k+1) n f r
				else error ("failed test on: " ++ show xs ++ " " ++ show ys)

testProperty :: ([Int] -> [Int] -> Bool) -> ([Int] -> [Int] -> Bool) -> IO ()
testProperty f p = testR 1 100 f (\x y r -> r ==> p x y)