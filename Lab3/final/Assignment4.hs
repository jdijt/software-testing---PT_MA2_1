module Assignment4 where

import PropositionGenerator
import Assignment3
import Lecture3
import Test.QuickCheck
import Data.List
import Control.Monad

compareTest :: IO Bool
compareTest = do
        randomForm <- (generateValidForm $ generateProp)
        let valuations = allVals randomForm
        let result = map (\x -> evl x randomForm) valuations
        let cnfResult = map (\x -> evl x (toCNF randomForm)) valuations
        return (result == cnfResult)


--data Form = Prop Name
--          | Neg  Form
--          | Cnj [Form]
--          | Dsj [Form]
--          | Impl Form Form
--          | Equiv Form Form
--          deriving Eq


someForm = sized someForm'
someForm' 0 = liftM Prop (choose(0,9))
someForm' n | n > 0 =
	oneof [liftM Prop (choose(0,9)),
	       liftM Neg subForm,
--	       liftM Cnj subFormArray,
	       liftM2 Impl subForm subForm,
	       liftM2 Equiv subForm subForm]
  where subForm = someForm' (n `div` 2)
--        subFormArray = [someForm' (n `div` 2)]

--subForms n = do
--            repeat <- getRandomInt 0 2
--            if repeat == 0 then return [(someForm' (n `div` 2))]
--            else (someForm' (n `div` 2)) : [subForms n]
