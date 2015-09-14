module ParseTest where

import Parse
import System.Random

basicParseTest :: Bool
basicParseTest = and [parse "" == [],
                      parse "*(4" == [],
                      parse "+5" == [],
                      parse "- ==>" == [],
                      parse "-(2)" == [],
                      parse "<=> 3" == [],
                      parse "-4" == [Neg $ Prop 4],
                      parse "-*(3 2)" == [Neg $ Cnj [Prop 3, Prop 2]],
                      parse "*(3 2)3921" == [Cnj [Prop 3, Prop 2]],
                      parse "+(3 2 1)" == [Dsj [Prop 3, Prop 2, Prop 1]],
                      parse "(3 ==> 2)" == [Impl (Prop 3) (Prop 2)],
                      parse "(3 <=> 2)" == [Equiv (Prop 3) (Prop 2)]]


testValidForms :: IO ()
testValidForms = testR 1 100 parse

testR:: Integer -> Integer -> (String -> [Form]) -> IO ()
testR k n f = if k == n then print (show n ++ " test passed")
              else do 
                 randomform <- generateValidForm $ generateProp
                 if (f $ show randomform) == [randomform] then  
                    do print ("pass on: " ++ show randomform)
                       testR (k+1) n f
                 else error ("failed test on: " ++ show randomform)

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
