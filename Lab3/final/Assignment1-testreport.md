# Test report for Assignment 1

The total amount of time spent by two persons on this Lab exercise is 5 hours.

## Source
The source is located in the following files: `Assignment1.hs` for the definitions and test cases, `Lecture3.hs` for the functions provided in lecture 3.

## Tests
All tests are based on the following three lists, the full implementation of these can be seen in `Assignment1.hs`:
```
-- Contradictions
baseContradictions :: [Form]

-- Tautologies
baseTautologies :: [Form]

-- These formulas are neither tautologies or contradictions
otherForms :: [Form]
```

### Test cases
To run all test cases execute `runAllTests` with `Assignment1.hs` loaded.

1. `testContradiction `: In this case we test if `contradiction` recognizes contradictions from the list of base contradictions. In addition to that we know that the negation of a tautology is a contradiction as well, so we use the negated forms from `baseTautologies` to increase the number of test cases.
2. `testOthers`: This test case is to check if `contradiction` and `tautology` both work for formulas that are not tautologies and not contradictions.
3. `testTautology`: This case is to check if `tautology` works for the tautologies from `baseTautologies` and the negated contradictions from `baseContradictions`, following the same logic as used for `testContradiction`.
4. `testEntails`: For the entails method we know the following properties hold, so these are the properties we use for testing:
   - A contraction can imply anything;
   - Anything can imply a tautology;
   - Anything can imply itself.
5. `testNotEntails`: Here we use 3 properties again, somewhat similar to `testEntails`:
   - A non contradiction cannot imply a contradiction;
   - A tautology cannot imply a non tautology;
   - A proposition cannot imply the negation of itself.
6. `testEquiv`: The property used here is that `p <==> p` is always true.
7. `testNotEquiv`: The properties used here for testing are the following:
   - A tautology is never equal to a contradiction;
   - A non tautology is never equal to a tautology;
   - A non contradiction is never equal to a contradiction.
