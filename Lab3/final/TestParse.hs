module TestParse where 

import Parse

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

