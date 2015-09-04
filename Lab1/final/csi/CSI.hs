module CSI

where

import Data.Bits

data Boy = Matthew | Peter | Jack | Arnold | Carl
           deriving (Eq,Show)

boys :: [Boy]
boys = [Matthew, Peter, Jack, Arnold, Carl]

says :: Boy -> Boy -> Bool

--Matthew: Carl didn’t do it, and neither did I.
says Matthew Carl = False
says Matthew Matthew = False
says Matthew _ = True

--Peter: It was Matthew or it was Jack.
says Peter Matthew = True
says Peter Jack = True
says Peter _ = False

--Jack: Matthew and Peter are both lying.
says Jack x = not (says Matthew x) && not (says Peter x)

--Arnold: Matthew or Peter is speaking the truth, but not both.
says Arnold x = says Matthew x `xor` says Peter x

--Carl: What Arnold says is not true.
says Carl x = not (says Arnold x)

accusers :: Boy -> [Boy]
accusers x = filter (\y -> says y x) boys

guilty, honest :: [Boy]
guilty = filter (\x -> (length $ accusers x) == 3) boys
honest = accusers $ head guilty