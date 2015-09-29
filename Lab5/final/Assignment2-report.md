# Assignment 2

> Refactor the code along the lines of this proposal, and next compare the two versions for extendability and efficiency. Which of the two versions is easier to modify for NRC Sudokus, and why? Which of the two versions is more efficient? Devise your own testing method for this, and write a short test report.

> Deliverables: Refactored code, test report, indication of time spent.

The source can be found in `Assignment2.hs` and `Assignment2Test.hs`. We have moved the refactored functions to the top of the file.

## Indication of time spend:
The total amount of time spend by two persons on this Lab exercise is 12 hours.

## Comparison of solutions:

### Extending the Sudoku problem with additional constraints.
Extending the new version is significantly easier compared to the original implementation.

In the original implementation both `prune`, `consistent` and `freeAtPos` had hardcoded cases to separate the subgrid, row and column constraints. Adding another constraint involved editing multiple blocks of Haskell code.

In our new implementation `prune`, `consistent`  and `freeAtPos` use the proposed definition for constraints. These functions now work in a generic manner on any list of constraints.
Adding constraints can now be done by extending the 'allConstrnt' list.

### Efficiency of the new constraint system.
We expect the new implementation to be slower. This is because the `prune` and `freeAtPos` functions have become more complex due to having to look up the constraints dynamically.

We have tested this by generating 10 Sudoku grids (`exampleGrids`) using `genGridList`.
Then we compared the runtime of `testrtAssignment2` and `testrtLecture5` by setting the `+s` flag in ghci (`> :set +s`).

The result for `testrtAssignment2` was as follows:
```
(2.72 secs, 562156016 bytes)
```

The result for `testrtLecture5` was as follows: 
```
(1.00 secs, 577505384 bytes)
```
This is reproducible across runs (although this requires a restart of ghci). So we can conclude that the proposed implementation runs slower.