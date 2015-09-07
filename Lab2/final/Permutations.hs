module Permutations where

import Data.List
import System.Random

isPermutation :: Eq a => [a] -> [a] -> Bool
isPermutation [] [] = True
isPermutation [] _ = False
isPermutation (x:xs) ys = x `elem` ys && (isPermutation xs (delete x ys))


-- Testable properties
isEqualLength :: [a] -> [a] -> Bool
isEqualLength a b = length a == length b

-- Based on: For each element a of the first list there must be an element b in the second list sucht that a == b
containsAll :: Eq a => [a] -> [a] -> Bool
containsAll a b = all (\x -> any (==x) b) a

-- Function composition for properties of type a -> a -> Bool
(.&&.) :: (a -> a -> Bool) -> (a -> a -> Bool) -> a -> a -> Bool
p .&&. q = (\x y -> p x y || q x y)

-- Additional logic notation
infix 1 ==> 

(==>) :: Bool -> Bool -> Bool
p ==> q = (not p) || q
forall = flip all

-- Testcase generation:
getRandomInt :: Int -> IO Int
getRandomInt n = getStdRandom (randomR (0,n))

genIntList :: IO [Int]
genIntList = do 
  k <- getRandomInt 5
  n <- getRandomInt 3
  getIntL k n

getIntL :: Int -> Int -> IO [Int]
getIntL _ 0 = return []
getIntL k n = do 
   x <-  getRandomInt k
   xs <- getIntL k (n-1)
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
testPost f p = testR 1 100 f (\x y r -> r ==> p x y)
