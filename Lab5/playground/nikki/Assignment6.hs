module Assignment6 where

import Lecture5 hiding (main, minimalize, genProblem)
import Control.Monad
--import Control.Monad.LoopWhile

getThird :: (a,a,[a]) -> [a]
getThird (_,_,[]) = []
getThird (_,_,(x:xs)) = x : xs 

minimalize :: Int -> [(Int,Row,Column,[Value])] -> Node -> [(Row,Column)] -> ([(Int,Row,Column,[Value])],Node)
minimalize level as n [] = (as,n)
minimalize level as n ((r,c):rcs) | uniqueSol n' && numberPossibleVal <= level = minimalize level (a:as) n' rcs
                                  | otherwise    = minimalize level as n rcs
                where n' = eraseN n (r,c)
                      numberPossibleVal = length (getThird (findConstraint r c (snd n')))
                      a = (numberPossibleVal,r,c, getThird (findConstraint r c (snd n')))

findConstraint :: Row -> Column -> [Constraint] -> Constraint
findConstraint r c (z@(x,y,_):xs) = if (r == x) && (c == y) then z
                            else findConstraint r c xs

genProblem :: Int -> Node -> IO ([(Int,Row,Column,[Value])],Node)
genProblem level n = do 
                      ys <- randomize xs
                      return (minimalize level [] n ys)
                      where xs = filledPositions (fst n)

--main :: Int -> IO Int
main level = do 
              [r] <- rsolveNs [emptyN]
--              showNode r
              (i,s)  <- genProblem level r
--              showNode s;
--              print (maximum [x | (x,y,z,t) <- i]);
--              print (sum $ map (\(x, _, _, _) -> x) i)
              return (sum $ map (\(x, _, _, _) -> x) i)
              -- TODO print "Level is: " ++
