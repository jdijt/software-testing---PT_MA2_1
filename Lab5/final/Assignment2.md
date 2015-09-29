# Assignment 2

> Refactor the code along the lines of this proposal, and next compare the two versions for extendability and efficiency. Which of the two versions is easier to modify for NRC sudokus, and why? Which of the two versions is more efficient? Devise your own testing method for this, and write a short test report.

> Deliverables: Refactored code, test report, indication of time spent.

## Indication of time spend:
tbd.

## Comparison of solutions:

### Extending the Sudoku problem with additional contraints.
Extending the new version is significantly easier compared to the original implementation.

In the original implementation both `prune`, `consistent` and `freeAtPos` had hardcoded cases to seperate the subgrid, row and column constraints. Adding another constraint involved editing multiple blocks of haskell code.

In our new implementation `prune`, `consistent`  and `freeAtPos` use the proposed definition for constraints. These functions now work in a generic manner on any list of constraints.
Adding constraints can now be done by extending the 'allConstrnt' list.

### Efficiency of the new constraint system.
We expect the new implementation to be slightly slower. This is because the `prune` and `freeAtPos` functions have become more complex due to having to look up the constraints dynamically.



