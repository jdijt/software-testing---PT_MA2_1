# Test report for Permutations.hs

## Testable properties
These two properties can be used to test the output.
Both are weaker than the postcondition (a is a permutation of b). Combined they can be used to check if isPermutation gave the right result.

```
isEqualLength :: [a] -> [a] -> Bool
isEqualLength a b = length a == length b

-- Based on: For each element a of the first list there must be an element b in the second list sucht that a == b
containsAll :: Eq a => [a] -> [a] -> Bool
containsAll a b = all (\x -> any (==x) b) a
```

## Tests with well chosen Lists:
The intention of these test cases is to test the edge case of the function and after that if the function is correct for larger cases.
We test four cases:

1. Empty lists (Base cases of the recursion)
2. Permutations
3. Non permutations of equal size
4. Non permutations of differing size.

### Base case test run:
```
*PermutationsTest> testBasic
True
```

## Automated tests
We have implemented two methods for automated testing.

The first method works by providing random input that conforms to the preconditions (two lists of the same Eq type without double entries) and checking the result.

### Random input tests
These tests work by providing isPermutation with two lists of size `n` where `n` is in `{0,1,2}` containing values from the list \[0,1,2\].
Given these parameters there are 10 possible input lists: \[\], \[x\] (x in \[0,1,2\]), \[x,y\] (x in \[0,1,2\], y in \[0,1,2\] && y != x), since there are two inputs there are 10*10 = 100 possible inputs to generate.

Within the 100 possible inputs there are 16 (1+3+6+6: \[\] \[\], \[x\] \[x\], \[x,y]\[x,y\] and \[x,y\],\[y,x\]).
So if we generate 100 test cases the chance of there not being any permutations in the generated input is (84/100)^100 = 2.67872793e-8 i.e.: extremely unlikely.
So the random tests will, almost certainly, provide input for which `isPermutation` will be `True`.

The performed check is a weak one. We know for sure that if two lists are each others permutations it implies that they are equal length and they contain all of each others items: "isPermutation a b ==> containsAll a b" and "isPermutation a b ==> isEqualLength a b". This can be seen in the implementation of testProperty.

#### Random tests call:
```
*PermutationsTest> testRandom
.... -- Lots of output
"100 tests passed"
```

### Happy flow test

This test will generate all permutations of randomly generated list. The goal is to test whether it successfully detects all permutations.

#### Happy flow test call:
```
*PermutationsTest> testPermutations
"pass on all permutations of : [2,6]"
```
