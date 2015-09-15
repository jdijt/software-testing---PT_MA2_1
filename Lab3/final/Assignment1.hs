module Assignment1 where

import Lecture3

contradiction :: Form -> Bool
contradiction f = all (not.(`evl` f)) (allVals f)

tautology :: Form -> Bool
tautology f = all (`evl` f) (allVals f)

-- | logical entailment
entails :: Form -> Form -> Bool
entails g h = tautology (Impl g h)

-- | logical equivalence
equiv :: Form -> Form -> Bool
equiv g h = tautology (Equiv g h)


baseContradictions :: [Form]
baseContradictions = [Cnj [Prop 1, Neg (Prop 1)]
                     ,Cnj [Neg (Prop 1), Prop 1]
                     ,Equiv (Prop 1) (Neg (Prop 1))]

baseTautologies :: [Form]
baseTautologies = [Dsj [Prop 1, Neg (Prop 1)],
                   Dsj [Neg (Prop 1), Prop 1],
                   Equiv (Prop 1) (Prop 1)]

-- These formulas are neither tautologies or contradictions
otherForms :: [Form]
otherForms = [Prop 1,
              Neg (Prop 1),
              Dsj [Prop 1, Prop 2],
              Cnj [Prop 1, Prop 2],
              Impl (Prop 1) (Prop 2),
              Equiv (Prop 1) (Prop 2)]

runAllTests :: Bool
runAllTests = and [testContradiction, testOthers, testTautology, testEntails, testNotEntails, testEquiv, testNotEquiv]

testContradiction :: Bool
testContradiction = all contradiction (baseContradictions ++ map Neg baseTautologies)

testOthers :: Bool
testOthers = all (\f -> not (contradiction f) && not (tautology f)) otherForms

testTautology :: Bool
testTautology = all tautology (baseTautologies ++ map Neg baseContradictions)

testEntails :: Bool
testEntails = all (uncurry entails) (concat [[(c, x) | c <- baseContradictions, x <- otherForms],
                                             [(x, t) | t <- baseTautologies, x <- otherForms],
                                             [(x, x) | x <- otherForms]])

testNotEntails :: Bool
testNotEntails = all (not.uncurry entails) (concat [[(x, c) | c <- baseContradictions, x <- otherForms],
                                             [(t, x) | t <- baseTautologies, x <- otherForms],
                                             [(x, Neg x) | x <- otherForms]])

testEquiv :: Bool
testEquiv = all (uncurry equiv) (concat [[(c, c) | c <- baseContradictions],
                                         [(x, x) | x <- otherForms],
                                         [(t, t) | t <- baseTautologies]])

testNotEquiv :: Bool
testNotEquiv = all (not.uncurry equiv) (concat [[(t, c) | c <- baseContradictions, t<- baseTautologies],
                                            [(x, t) | x <- otherForms, t <- baseTautologies],
                                            [(c, x) | c <- baseContradictions, x <- otherForms]])
