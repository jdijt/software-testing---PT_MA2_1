module Permutations where

import Data.List
import System.Random

isPermutation :: Eq a => [a] -> [a] -> Bool
isPermutation [] [] = True
isPermutation [] _ = False
isPermutation (x:xs) ys = x `elem` ys && (isPermutation xs (delete x ys))

----------------------
-- Testable properties
----------------------
isEqualLength :: [a] -> [a] -> Bool
isEqualLength a b = length a == length b

-- Based on: For each element a of the first list there must be an element b in the second list sucht that a == b
containsAll :: Eq a => [a] -> [a] -> Bool
containsAll a b = all (\x -> any (==x) b) a

----------------------
-- Helpers
----------------------
-- Function composition for properties of type a -> a -> Bool
(.&&.) :: (a -> a -> Bool) -> (a -> a -> Bool) -> a -> a -> Bool
p .&&. q = (\x y -> p x y || q x y)

-- Additional logic notation
infix 1 ==> 
(==>) :: Bool -> Bool -> Bool
p ==> q = (not p) || q

----------------------
-- Random tests
----------------------
getRandomInt :: Int -> IO Int
getRandomInt n = getStdRandom (randomR (0,n))

genIntList :: IO [Int]
genIntList = do 
	n <- getRandomInt 3
	getIntL [0..5] n

pickInt :: [Int] -> IO Int
pickInt is = do
	x <- getRandomInt (length is - 1)
	return (is !! x)

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
				xs <- genIntList
				ys <- genIntList
				if r xs ys (f xs ys) then do 
					print ("pass on: " ++ show xs ++ " " ++ show ys)
					testR (k+1) n f r
				else error ("failed test on: " ++ show xs ++ " " ++ show ys)

testPost :: ([Int] -> [Int] -> Bool) -> ([Int] -> [Int] -> Bool) -> IO ()
testPost f p = testR 1 1000 f (\x y r -> r ==> p x y)
