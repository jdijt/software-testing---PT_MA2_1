
# Test report for Permutations.hs

# Tests with well chosen Lists:
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
