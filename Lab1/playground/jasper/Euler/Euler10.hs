module Euler10 where

import Primes

primeSum :: Integer
primeSum = sum $ takeWhile (2000000>) primes
