module Assignment4 where

import Assignment3
import Lecture3
import Test.QuickCheck
import Control.Monad

validCnf :: Form -> Bool
validCnf form = formsAreEquiv form cnfForm (allVals form) && isInCNF cnfForm
            where cnfForm = toCNF form

formsAreEquiv :: Form -> Form -> [Valuation] -> Bool
formsAreEquiv x y valutations = evalAll x valutations == evalAll y valutations

evalAll :: Form -> [Valuation] -> [Bool]
evalAll form =  map (`evl` form)

isInCNF :: Form -> Bool
isInCNF x = isProp x || isNegProp x || isDsjInCNF x || isCnjInCNF x

isCnjInCNF :: Form -> Bool
isCnjInCNF (Cnj xs) = all (\x -> isProp x || isNegProp x || isDsjInCNF x) xs
isCnjInCNF _ = False

isDsjInCNF :: Form -> Bool
isDsjInCNF (Dsj xs) = all (\x -> isProp x || isNegProp x) xs
isDsjInCNF _ = False

isNegProp :: Form -> Bool
isNegProp (Neg n) = isProp n
isNegProp _ = False

isProp :: Form -> Bool
isProp (Prop _) = True
isProp _ = False

randomPropTest :: Property
randomPropTest = forAll randomForm validCnf

randomForm :: Gen Form
randomForm = randomForm' 4

randomForm' :: Int -> Gen Form
randomForm' 0 = liftM Prop (choose(0,9))
randomForm' n | n > 0 =
	oneof [liftM Prop (choose(0,9)),
	       liftM Neg subForm,
	       liftM Cnj subFormList,
           liftM Dsj subFormList,
	       liftM2 Impl subForm subForm,
	       liftM2 Equiv subForm subForm]
      where subForm = randomForm' (n `div` 2)
            subFormList = do
                size <- elements [0..3]
                vectorOf size subForm
