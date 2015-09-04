{-# OPTIONS_GHC -Wall #-}
module CSI where

data Boy = Matthew | Peter | Jack | Arnold | Carl 
            deriving (Eq,Show)
 
boys::[Boy]
boys = [Matthew, Peter, Jack, Arnold, Carl]


says :: Boy -> Boy -> Bool
says Matthew Matthew = False									--Matthew: I didnt do it 
says Matthew Carl = False										--Matthew: Neither did carl
says Matthew _ = True											--It was one of the others (implied)
says Peter Matthew = True										--Peter blames Matthew
says Peter Jack = True											--Or Jack..
says Peter _ = False											--And not the rest.
says Jack b = not ((says Peter b) || (says Matthew b))			--Jack says both matthew and peter are lieing 
says Arnold b = (says Peter b) `xor` (says Matthew b)	 		--Arnold claims either peter or matthew lies, but not both.
says Carl b = not (says Arnold b)								--Carl says arnold lies.


accusers :: Boy -> [Boy]
accusers boy = [b | b <- boys, says b boy]


--Assumes the guilty one as accused by the three (honest) boys.
guilty :: [Boy]
guilty = [b | b <- boys, (length $ accusers b) == 3]

--Assumes there is only one guilty party (only the first is considered).
honest :: [Boy]
honest = [b | b <- boys, any (b==) (head guilty)]

-- Helper functions / definitions:
xor :: Bool -> Bool -> Bool
xor False False = False
xor True True = False
xor _ _ = True
