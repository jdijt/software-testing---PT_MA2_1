module Assignment2 where

import PropositionGenerator
import Lecture3

basicParseTest :: Bool
basicParseTest = and [null (parse ""),
                      null (parse "*(4"),
                      null (parse "+5"),
                      null (parse "- ==>"),
                      null (parse "-(2)"),
                      null (parse "<=> 3"),
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
                 randomform <- generateValidForm generateProp
                 if f (show randomform) == [randomform] then
                    do print ("pass on: " ++ show randomform)
                       testR (k+1) n f
                 else error ("failed test on: " ++ show randomform)
