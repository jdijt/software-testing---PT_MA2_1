module Assignment6 where

import Lecture5 hiding (main, minimalize, genProblem)

getThird :: (a,a,[a]) -> [a]
getThird (_,_,[]) = []
getThird (_,_,x:xs) = x : xs

minimalize :: Int -> [Int] -> Node -> [(Row,Column)] -> ([Int],Node)
minimalize _ as n [] = (as,n)
minimalize level as n ((r,c):rcs) | uniqueSol n' && numberPossibleVal <= level = minimalize level (numberPossibleVal:as) n' rcs
                                  | otherwise    = minimalize level as n rcs
                where n' = eraseN n (r,c)
                      numberPossibleVal = length (getThird (findConstraint r c (snd n')))

findConstraint :: Row -> Column -> [Constraint] -> Constraint
findConstraint r c (z@(x,y,_):xs) = if (r == x) && (c == y) then z
                            else findConstraint r c xs

genProblem :: Int -> Node -> IO ([Int],Node)
genProblem level n = do
                      ys <- randomize xs
                      return (minimalize level [] n ys)
                      where xs = filledPositions (fst n)

main :: Int -> IO Int
main level = do
              [r] <- rsolveNs [emptyN]
              showNode r
              (i,s)  <- genProblem level r
              showNode s
              let difficulty = sum i
              print ("The minimal problem for n = " ++ show level ++ " has a difficulty of " ++ show difficulty ++ " on a scale where 30 is really easy and 130 is insane.")
              return difficulty
