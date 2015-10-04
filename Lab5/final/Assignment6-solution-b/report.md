# Classifying difficulty

For this solution we take a different approach for determining the difficulty of a Sudoku. Instead of rating a certain Sudoku problem, we will rate the action that the user applies on a Sudoku to advance to a more solved Sudoku. A more solved Sudoku is a Sudoku where more spots are solved or unsolved spots have fewer remaining options. This idea is based on Palének 2015.

### Actions

All available actions will transition the Sudoku into a more solved state. The actions are:

* Set a coordinate to a certain value.
* Remove a value from the related spots of a coordinate
* Remove values from a group of coordinates.

### Strategies

The suggested implementation uses 3 strategies that imply actions on the subject Sudoku problem. All strategies are based on logical reasoning and will never bring the Sudoku problem in an invalid state. These strategies are:

- **Naked Single**: All related spots (based on the constraints) contain all values {1..9} except for `n`with `n` in {1..9}. The solution for this coordinate must be `n`.

- **Hidden Single**: Only one coordinate in a certain constraint has the possibility to hold `n`. From this it follows that `n` must be placed on this coordinate.

- **Naked Pairs**: Two coordinates with one or more shared constraints have two remaining possibilities, which are the same. We can remove these two values from the intersect of the related spots for these two coordinates.

These strategies are provided by Palének 2015 and [SudokuWiki](http://www.Sudokuwiki.org/).

### Putting it Together

To determine the difficulty of a solution we take a Sudoku problem and we apply different strategies on it. We then take the easiest strategy (assuming a human would do the same) then apply all provided actions from this strategy to the Sudoku problem. At this moment we also increase the the difficulty level with a constant<sup>1</sup> bound to the strategy multiplied with the number of hints the strategy provided<sup>2</sup>.

We repeat this cycle until no more actions are provided. If the Sudoku is solved, we also get the difficulty level and we can compare this to other Sudoku problems. If the Sudoku problem isn't solved, the problem is not solvable with logical reasoning<sup>3</sup> and we supply the unsolved solution with the difficulty of the steps taken.

### Running the Code

The program can be executed by loading the `Problem.hs` module and running one of the following statements.

```
doPuzzle puzzle1
doPuzzle puzzle2
doPuzzle puzzle3
```

### Software Components

* `Problem.hs` The main file in the module that contains the logic to repeatedly apply actions until the Sudoku is solved or a dead end is reached.
* `Domain.hs` This file contains all types that were used in the different modules and some implementations to show the data structures.
* `Puzzles.hs` This file contains 3 sample puzzles. More can be added.
* `Strategies.hs` This file contains all strategies with the related difficulty constants.
* `Constraints.hs` This file contains all constraints in the Sudoku<sup>4</sup> (boxes, rows and columns).
* `Utils.hs` This file contains helper functions that are used in the different modules like the different strategies.


## *Notes*

1. The current constants are fictional and should be set based on experimental results.
1. In this implementation we use all actions from the lowest rated strategy that provides one or more actions. A human however would maybe use one of these actions and than return back to a easier strategy.  
1. The code uses only a few strategies when more are available, these should be implemented to complete the solver.
1. This structure allows it to easily introduce new constrains as for example the NRC-Sudoku constraints as implemented in the other exercises.
