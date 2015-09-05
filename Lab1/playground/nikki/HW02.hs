{- 

Lab 1: Crime Scene Investigation
Nikki van Ommeren
10017704
04 - 09 - 2015

Statements
Matthew: Carl didn’t do it, and neither did I.
Peter: It was Matthew or it was Jack.
Jack: Matthew and Peter are both lying.
Arnold: Matthew or Peter is speaking the truth, but not both.
Carl: What Arnold says is not true.

-}

module HW02 where

import Data.Bits
import Data.List

data Boy = Matthew | Peter | Jack | Arnold | Carl 
           deriving (Eq,Show)

boys = [Matthew, Peter, Jack, Arnold, Carl]

-- |Returns false when the first Boy lies when the second Boy is the thief
says :: Boy -> Boy -> Bool
says Matthew Carl = False
says Matthew Matthew = False 
says Matthew _ = True
says Peter Matthew = True
says Peter Jack = True
says Peter _ = False
says Jack Carl = True
says Jack _ = False
says Arnold x = (says Matthew x) `xor` (says Peter x)
says Carl x = not (says Arnold x)

-- |Evaluates how many boys are lying when Boy y would be the thief
eval :: [Boy] -> [([Bool],Boy)]
eval [] = []
eval (y:ys) = ([ says x y | x <- boys],y):eval ys

-- |Finds which boy is the thief
guilty :: Boy
guilty = head [ y | (x,y) <- eval boys, x `elem` check] 
         where check = (nub . permutations) [True, True, True, False, False]

-- |Indicates which boys are lying
liars :: [(Boy, Bool)]
liars = [ (x, says x guilty) | x <- boys]




