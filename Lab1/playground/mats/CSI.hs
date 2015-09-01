module CSI

where

import Data.List;

data Boy = Matthew | Peter | Jack | Arnold | Carl
           deriving (Eq,Show)

boys :: [Boy]
boys = [Matthew, Peter, Jack, Arnold, Carl]

says :: Boy -> Boy -> Bool

says Matthew Carl = False
says Matthew Matthew = False
says Matthew _ = True
says Peter Matthew = True
says Peter Jack = True
says Peter _ = False
says Jack x = not (says Matthew x) && not (says Peter x)
says Arnold x = says Matthew x /= says Peter x
says Carl x = not $ says Arnold x

accusers :: Boy -> [Boy]
accusers x = filter (\y -> says y x) boys

guilty, honest :: [Boy]
guilty = filter (\x -> (length $ accusers x) == 3) boys
honest = accusers $ head guilty