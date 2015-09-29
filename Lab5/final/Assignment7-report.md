# Report for Assignment 7

The total amount of time spent by one person on this Lab exercise is 2 hours.

## Source
The source is located in the file `Assignment7.hs`. The module `Assignment1` is used for generating NRC sudokus; `Lecture5` is used for generating regular sudokus.

## Expectations
Due to the larger amount of constraints we expect NRC sudokus to require less hints on avarage.

## Method
The method used is simple. 100 Sudokus of the both types are generated, the amount of hints they provide are counted and the avarage amount of hints is calculated. See the functions `getAvgsHintsA1Sudokus` (for NRC Sudokus) and `getAvgHintsL5Sudokus` (for regular Sudokus).

The results are as follows:
```
*Assignment7> getAvgHintsL5Sudokus 100
24.28

*Assignment7> getAvgHintsA1Sudokus 100
16.99

```

repeated runs give similar results.

## Conclusion
On avarage an NRC Sudoku needs 7 hints less than a regular Sudoku for a unique solution to be possible.


