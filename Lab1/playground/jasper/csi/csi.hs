{-# OPTIONS_GHC -Wall #-}
module csi where

data Boy = Matthew | Peter | Jack | Arnold | Carl 
            deriving (Eq,Show)
 
boys = [Matthew, Peter, Jack, Arnold, Carl]


{-|
 - && is used in a 'Boy AND boy are lieing' accusation. This gives the ones accused by the liears the benefit of the doubt (in case of a conflict the accused is exonerated).
 - || is used in a
 -
 -
 -}
says :: Boy -> Boy -> Bool
says Matthew Matthew = False		--Matthew: I didnt do it 
says Matthew Carl = False			--Matthew: Neither did carl
says Matthew _ = True				--It was one of the others (implied)
says Peter Matthew = True			--Peter blames Matthew
says Peter Jack = True				--Or Jack..
says Peter _ = False				--And not the rest.
says Jack b = (not says Peter b)	--Jack says both matthew and peter are lying
				&& (not says Mattew b)

