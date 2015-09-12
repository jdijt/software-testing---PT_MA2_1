module DerangementsTest where

import Permutations
import Derangements
import Data.List
import System.Random

----------------------
-- Testable properties
----------------------
noMatchingIndices :: Eq a => [a] -> [a] -> Bool
noMatchingIndices xs ys = all (uncurry (/=)) (zip xs ys)

--isPermutation, imported from Permutations.hs

----------------------
-- Tests
----------------------

--TestBasic
testBasic :: Bool
testBasic = and [isDerangement ([]::[Int]) [],
				not (isDerangement [1] []),
				not (isDerangement [] [1]),
				not (isDerangement [1] [1]),
				isDerangement [1,2] [2,1],
				not (isDerangement [1] [2]),
				not (isDerangement [1,2,3] [2,1,3])]

-- 'Random based tests'
testHasPermutationProperty = testProperty isDerangement isPermutation
testHasNoMatchingIndicesProperty = testProperty isDerangement (\x y -> length x == length y && noMatchingIndices x y)
testHasAllProperties = testProperty isDerangement (isPermutation .&&. noMatchingIndices)

-- 'Statistic based test'
testStatistic :: Bool
testStatistic = length (filter (isDerangement [1..4]) (permutations [1..4])) == 9

----------------------
-- Helpers
----------------------
-- Function composition for properties of type a -> a -> Bool
(.&&.) :: (a -> a -> Bool) -> (a -> a -> Bool) -> a -> a -> Bool
p .&&. q = \x y -> p x y && q x y

-- Additional logic notation
infix 1 ==>
(==>) :: Bool -> Bool -> Bool
p ==> q = not p || q

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
