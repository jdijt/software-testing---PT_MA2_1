module Assignment6

where

import Assignment5
import Lecture6
import Control.Monad

testMillerRabin k = do
  res <- testMillerRabin' 100 []
  return (fromIntegral (sum res) / fromIntegral(length res)) where

  testMillerRabin' 0 xs = return xs
  testMillerRabin' n xs = do
      l <- filterM (primeMR k) (take 100 carmichael)
      testMillerRabin' (n-1) (length l:xs)
