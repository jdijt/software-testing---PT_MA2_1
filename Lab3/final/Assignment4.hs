module Assignment4 where

import PropositionGenerator
import Assignment3
import Lecture3
import Test.QuickCheck
import Data.List

compareTest :: IO Bool
compareTest = do 
        randomForm <- (generateValidForm $ generateProp)
        let valuations = allVals randomForm
        let result = map (\x -> evl x randomForm) valuations
        let cnfResult = map (\x -> evl x (toCNF randomForm)) valuations
        return (result == cnfResult)
