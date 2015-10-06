module Assignment4

where

import Lecture6
import Assignment3

firstFailingFermat :: Int -> [Integer] -> IO Integer
firstFailingFermat k (c:cs) = do
  res <- prime_tests_F k c
  if res then return c else firstFailingFermat k cs

firstFailingFermats :: Int -> Integer -> IO [Integer]
firstFailingFermats k n = mapM (\_ -> firstFailingFermat k composites) [1..n]

minimumFailingFermat :: Int -> Integer -> IO Integer
minimumFailingFermat k n = do
  res <- firstFailingFermats k n
  return (minimum res)
