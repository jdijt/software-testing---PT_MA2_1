module Assignment4 where

import Assignment3
import Lecture3
import Test.QuickCheck
import Data.List
import Control.Monad

validCnf :: Form -> Bool
validCnf form = propositionsAreEquivalent form (toCNF form) (allVals form)

propositionsAreEquivalent :: Form -> Form -> [Valuation] -> Bool
propositionsAreEquivalent x y valutations = evalAll x valutations == evalAll y valutations

evalAll :: Form -> [Valuation] -> [Bool]
evalAll form valuations =  map (\x -> evl x form) valuations

randomPropTest :: Property
randomPropTest = forAll randomForm $ validCnf

randomForm :: Gen Form
randomForm = sized randomForm'


randomForm' :: Int -> Gen Form
randomForm' 0 = liftM Prop (choose(0,9))
randomForm' n | n > 0 =
	oneof [liftM Prop (choose(0,9)),
	       liftM Neg subForm,
	       liftM Cnj subFormList,
	       liftM2 Impl subForm subForm,
	       liftM2 Equiv subForm subForm]
      where subForm = randomForm' (n `div` 2)
            subFormList = do
                size <- elements [0..3]
                forms <- vectorOf size (subForm)
                return forms