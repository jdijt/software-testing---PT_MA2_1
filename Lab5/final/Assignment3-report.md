# Test Report for Assignment 3

The total amount of time spent by two persons on this Lab exercise is 6 hours.

The source is located in the file `Assignment3.hs`. We first tried to use QuickCheck, but we were not able to fit the existing generator in the QuickCheck structure. We then continued with using the `testR` testing method, which was provided in the Lecture of week 2. We ended up with a test function that uses the code of Lecture 5, but is really slow due to the performance of the `minimalize` function.

The testing method can be invoked with `testMinimalize`.

# Test properties

We identified three properties to verify the `minimalize` output:

- When an arbitrary filled field is erased on the output, the solution must be ambiguous.
- The output should have a unique solution.
- The unique solution for the output should be the input sudoku.
