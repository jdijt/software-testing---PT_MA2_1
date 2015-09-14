module Assignment1 where

import Forms

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
