# Test report for Permutations
Total time spent by two persons on this Lab exercise: 8 hours

## Source

The source can be found in the files `Permutations.hs` en `PermutationsTest.hs`. Load `PermutationsTest` with `:l PermutationsTest`. This will also load de `Permutations` module.

## Requirements
> A permutation of a finite list is another finite list with the same elements, but possibly in a different order. For example, [3,2,1] is a permutation of [1,2,3], but [2,2,0] is not. Write a function

>> isPermutation :: Eq a => [a] -> [a] -> Bool
> that returns True if its arguments are permutations of each other.

> Next, define some testable properties for this function, and use a number of well-chosen lists to test isPermutation. You may assume that your input lists do not contain duplicates. What does this mean for your testing procedure?

> Can you automate the test process? Use the techniques presented in this week's lecture.

> Deliverables: Haskell program, concise test report, indication of time spent.



## Postconditions

- The result should be True or False
- The result is True if the inputs are permutations of each other.

These two properties can be used to validate the result with regards to the postcondition.
Both are weaker than the postconditions. Combined they can be used to check if isPermutation gave the right result.

```
isEqualLength :: [a] -> [a] -> Bool
isEqualLength a b = length a == length b

-- Based on: For each element a of the first list there must be an element b in the second list sucht that a == b
containsAll :: Eq a => [a] -> [a] -> Bool
containsAll a b = all (`elem` b) a
```

## Tests

### Tests with well chosen Lists:
The intention of these test cases is to test the edge case of the function and after that if the function is correct for larger cases.
We test four cases:

1. Empty lists (Base cases of the recursion)
2. Permutations
3. Non permutations of equal size
4. Non permutations of differing size.

Running the tests with well chosen lists:
```
*PermutationsTest> testBasic
True
```

### Automated tests
We have implemented two methods for automated testing.

The first method works by providing random input that conforms to the preconditions (two lists of the same Eq type without double entries) and checking the result.

#### Random input tests
These tests work by providing isPermutation with two lists of size `n` where `n` is in `{0,1,2}` containing values from the list \[0,1,2\].
Given these parameters there are 10 possible input lists: \[\], \[x\] (x in \[0,1,2\]), \[x,y\] (x in \[0,1,2\], y in \[0,1,2\] && y != x), since there are two inputs there are 10*10 = 100 possible inputs to generate.

Within the 100 possible inputs there are 16 (1+3+6+6: \[\] \[\], \[x\] \[x\], \[x,y]\[x,y\] and \[x,y\],\[y,x\]).
So if we generate 100 test cases the chance of there not being any permutations in the generated input is (84/100)^100 = 2.67872793e-8 i.e.: extremely unlikely.
So the random tests will, almost certainly, provide input for which `isPermutation` will be `True`.

The performed check is a weak one. We know for sure that if two lists are each others permutations it implies that they are equal length and they contain all of each others items: "isPermutation a b ==> containsAll a b" and "isPermutation a b ==> isEqualLength a b". This can be seen in the implementation of testProperty.

##### Random tests call:
```
*PermutationsTest> testRandom
.... -- Lots of output
"100 tests passed"
```

#### Happy flow test

This test will generate all permutations of randomly generated list. The goal is to test whether it successfully detects all permutations.

##### Happy flow test call:
```
*PermutationsTest> testPermutations
"pass on all permutations of : [2,6]"
```