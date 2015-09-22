# Test Report for Assignment 3

The total amount of time spent by two persons on this Lab exercise is 8 hours.

The source is located in the file `Assignment3.hs`. We implemented `differenceSet` and `intersectionSet`. `unionSet` was already provided in the `SetOrd` implementation.

## Identified Properties

- Union
  - Arg 1 is subset of the result
  - Arg 2 is subset of the result
  - The difference between the result and arg 1 is a sub set of arg 2
  - The difference between the result and arg 2 is a sub set of arg 1
  - The length of the result is less then or equal to the sum of the lengths of the arguments
- Intersection
  - The result is a subset of arg 1
  - The result is a subset of arg 2
  - The intersect of the result with arg 1 is equal to the result
  - The intersect of the result with arg 2 is equal to the result
  - The intersect with the arguments flipped has the same result
- Difference
  - The result is a sub set of arg 1
  - The result does not overlap with arg 2
  - The union of the result and arg 2 covers the whole space
  - The result has no overlap when flipping the arguments

## Run Tests

Use the following commands to run the different tests:

```
testUnion
quickCheckUnion
testDifference
quickCheckDiff
testIntersection
quickCheckIntersection
```
