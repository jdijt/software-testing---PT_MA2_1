module Assignment7

where

import System.Random
import Lecture6

fromBinary :: [Int] -> Integer
fromBinary bits = sum $ zipWith toDec (reverse $ map toInteger bits) [0..]
  where
    toDec :: Integer -> Integer -> Integer
    toDec a b = a * (2 ^ b)


nBitNumber :: Int -> IO Integer
nBitNumber n = do
  as <- sequence $ fmap (\_-> randomRIO (0 :: Int, 1 :: Int)) [3..n]
  return (fromBinary (1:as ++ [1]))

primeWithNBits :: Int -> Int -> IO Integer
primeWithNBits k n = do
  a <- nBitNumber n
  res <- primeMR k a
  if res then return a else primeWithNBits k n

genNBitRsaKeyPair :: Int -> IO ((Integer,Integer),(Integer,Integer))
genNBitRsaKeyPair n = do
  let k = 4
  p <- primeWithNBits k n
  q <- primeWithNBits k n
  return (rsa_public p q, rsa_private p q)

-- | Put in a message as integer value it will be encoded end decoded with the key pair
rsaKeyPairDemo :: Integer -> IO ()
rsaKeyPairDemo m = do
  let bitCount = 256
  putStrLn ("Generating " ++  show bitCount ++ " key pair...\n")
  (public, private) <- genNBitRsaKeyPair bitCount

  putStrLn ("Message to encode: " ++ show m ++ "\n")
  putStrLn "Encoded message with public key:"
  let encoded = rsa_encode public m
  print encoded
  putStrLn "Decoded message with private key:"
  let decoded = rsa_decode private encoded
  print decoded
