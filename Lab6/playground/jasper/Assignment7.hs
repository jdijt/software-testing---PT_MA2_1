module Assignment7 where

import Lecture6
import System.Random

bitSizeToRange :: Integer -> (Integer,Integer)
bitSizeToRange n = (2^(n-1), 2^n - 1) -- (8,15) = 1000b to 1111b for bitsize 4


-- Generates n bits of which n-1 bits are random as an Integer (first bit is always 1).
generateRandomBits :: Integer -> IO Integer
generateRandomBits = randomRIO.bitSizeToRange


-- run MR check 5 times. 
-- This gives at most a 4^(-5) = 0.0009766 = 0.09766% chance of identifying a composite number as prime.
-- See: https://en.wikipedia.org/wiki/Miller%E2%80%93Rabin_primality_test#Accuracy_of_the_test
generateRandomPrime :: Integer -> IO Integer
generateRandomPrime n = do
    -- Use one bit less for size, then multiply by two and add 1. Gives all uneven numbers for n bits.
    candidate <- generateRandomBits (n-1)
    prime <- primeMR 5 ((2 * candidate) + 1)
    if prime then return candidate else generateRandomPrime n


-- some 1024 bit primes generated by the code above:
prime1,prime2,prime3,prime4 :: Integer

prime1 = 167551392195672266634315596316529938893996407523570659856571807069715166381901241655813499561551112065406813753524344386979659293034315947120556765692297816542159176388197711787778662354882023061576937959287388209511997788690229509213420851134128055094359156096797954836529295831916232274024723594698000928839
prime2 = 162441388309317870254607543493375364552332861398264775191665877825569364878520290148200155122727584359741631103862667186706795856154192619577504654416914732996071727059342495576189024117265632986811014217737409702092853448583045758590093294915061920938686129149684071727156221157786464950000025140125897544289
prime3 = 138470738261838345318277414607136017464290522144156707179160168469685028578844197225024514214385993956505017531617174382928018173814364520039950199024671298011322983356141955587030273763997565272250780194259200191434071237823151082844955431013747703419216470002617845381708135103531568917038611349035810395953
prime4 = 97021763611910824083100315200613965477504097203352680302451310407156715993425177610814758328568333708570190885494509653132197830455166842657790974614111377628579540636656801900445541588403995839069333387412072208803401555466435559884337680248359569707336467692643212937671232844477891067508035488174941774933