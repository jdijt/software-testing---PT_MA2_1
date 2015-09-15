module PropositionGenerator where

import Lecture3
import System.Random

generateValidForm :: IO Form -> IO Form 
generateValidForm x = do
           y <- getRandomInt 0 4
           let f = [generateNeg, generateCnj, generateDsj, generateImpl, generateEquiv] !! y
           z <- f x
           repeat <- getRandomInt 0 1
           if repeat == 0 then return z 
            else generateValidForm (f x)

generateNeg :: IO Form -> IO Form
generateNeg x = do
            y <- x
            return (Neg y)

generateCnj :: IO Form -> IO Form
generateCnj x = do
             y <- x
             z <- generateProp
             return (Cnj [y,z])

generateDsj :: IO Form -> IO Form
generateDsj x = do
             y <- x
             z <- generateProp
             return (Dsj [y,z])

generateImpl :: IO Form -> IO Form
generateImpl x = do
             y <- x
             z <- generateProp
             return (Impl y z)

generateEquiv :: IO Form -> IO Form
generateEquiv x = do
             y <- x
             z <- generateProp
             return (Equiv y z)

generateProp :: IO Form
generateProp =  do
           x <- getRandomInt 0 9
           return (Prop x)

          
getRandomInt :: Int -> Int -> IO Int
getRandomInt n m = getStdRandom (randomR (n, m))