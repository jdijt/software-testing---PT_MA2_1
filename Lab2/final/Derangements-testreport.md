# Test report for generating derangements

## Source

The source can be found in the files `Derangements.hs` and `DerangementsTest.hs`. Please load `DerangmentsTest` with `:load DerangmentsTest`. This will also load the `Derangments` source.

## Properties

The properties we identified for a list `a` to be a derangement of another list `b` are:

- `a` should be a permutation of `b`. From the `permutations` assignment we know that this implies that has the property holds that `a` and `b` have the same length.
- Let `n` be an arbitrary value from the set `{1,2,..,|a|}`, then it holds that `a[n] /= b[n]`.

**Implementation**

We use the implementation for the `isPermutation` property from the permutations lab exercise. We have added the `noMatchingIndices` function for the second property.

## Base Test Cases

- It should hold that `[]` is a derangement of  `[]`.
- It should hold that `[1,2]` is a derangement of `[2,1]`.
- It should **not** hold that `[1]` is a derangement of `[]`.
- It should **not** hold that `[]` is a derangement of `[1]`.
- It should **not** hold that `[1]` is a derangement of `[1]`.
- It should **not** hold that `[1]` is a derangement of `[2]`.
- It should **not** hold that `[1,2,3]` is a derangement of `[2,1,3]`.

To execute the base cases use the following command:

```
testBasic
```

## Test Automation

We concluded that test automation is possible for testing the derangement property since:

```
isDerangement ==> isPermutation .&&.  noMatchingIndices
```

This is the strongest postcondition we could find. Therefore we have added a random test that generates random lists and tests if the above implication holds. The following functions does this:

```
testHasPermutationProperty
testHasNoMatchingIndicesProperty
testHasAllProperties
```

## Statistics Test

We have added a test to check the statistics over a small domain. We took a list of length 4 and counted all possible permutations that have the property of `noMatchingIndices`. The result was `9` and we tested this with the following command:

```
testStatistics
```
