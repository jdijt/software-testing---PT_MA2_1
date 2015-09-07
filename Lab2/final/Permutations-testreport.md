
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
The intention of these testcases is to test the edgecase of the function and after that if it functions right for larger cases.
We test four seperate cases:

1. Empty lists (Base cases of the recursion)
2. Permutations
3. Non permutations of equal size
4. Non permutations of differing size.

```
*Permutations> isPermutation [] []
True
*Permutations> isPermutation [] [1]
False
*Permutations> isPermutation [1] []
False
*Permutations> isPermutation [1,2,3] [1,2,3]
True
*Permutations> isPermutation [1,2,3] [3,2,1]
True
*Permutations> isPermutation [1,2,3] [2,3,4]
False
*Permutations> isPermutation [1,2,3] [1,2,3,4]
False
*Permutations> isPermutation [1,2,3,4] [1,2,3]
False
```
