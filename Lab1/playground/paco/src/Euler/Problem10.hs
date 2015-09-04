module Euler.Problem10 where

import Euler.Primes

solution = sum $ takeWhile (<=2000000) primes1