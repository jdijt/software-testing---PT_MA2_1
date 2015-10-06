module Assignment6

where

import Assignment5
import Lecture6
import Control.Monad

testMillerRabin :: Fractional b => Int -> IO b
testMillerRabin k = do
  res <- testMillerRabin' 100 []
  return (fromIntegral (sum res) / fromIntegral(length res)) where

  testMillerRabin' 0 xs = return xs
  testMillerRabin' n xs = do
      l <- filterM (primeMR k) (take 100 carmichael)
      testMillerRabin' (n-1) (length l:xs)


generateMersennes :: Integer -> [Integer] -> IO ()
generateMersennes _ [] = return ()
generateMersennes 0 _ = return ()
generateMersennes n (p:ps)= do
  let x = 2^p-1
  res <- primeMR 1 x
  when res (putStrLn ("Found Mersenne prime of the form: 2^" ++ show p ++ "-1"))
  generateMersennes (if res then n - 1 else n) ps
