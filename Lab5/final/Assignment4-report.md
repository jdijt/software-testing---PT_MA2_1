# Report for Assignment 4

The total amount of time spent by two persons on this Lab exercise is 6 hours.

## Generator

TODO

## Findings

We found that the maximum number of empty blocks in a Sudoku problem is 4. This was due to the outcome of he generator we implemented and [this](http://puzzling.stackexchange.com/questions/309/what-is-the-maximum-number-of-empty-3x3-blocks-a-proper-sudoku-can-have) post where 'Emrakul' provides an answer.

In short: When you have an empty box, you are able to solve at most 3 positions when 3 out of 4 related boxes are not empty (horizontally or vertically). With a Sudoku where 5 boxes are empty (no matter the distribution), each empty box has too many related boxes that are empty as well.

> The related boxes are the boxes that are in the same row or column as the subject box.

As 'Emrakul' also shows, there are cases where it is possible to have 4 empty boxes (as our generator shows).
