# Report for Assignment 4

The total amount of time spent by two persons on this Lab exercise is 8 hours.

## Generator

The sources of the generator are in `Assignment4.hs`. 

Execute the method `mainEmptyBlocks 3` to generate solutions with 3 empty blocks. 
There is a chance to generate solutions with 4 empty blocks if you change the maximumEmptyBlocks parameter to 4: `mainEmptyBlocks 4`.

With two modifications it is possible to generate problems with empty nrcBlocks:

- Change the import to `Assignment1.hs`
- In the possibleBlocks function, change `blocks` to `blocksNRC` 
 
### Tests

To test the implementation of the generator with empty blocks we use the tests from assignment 3 with a few modifications to make it run with the generator.
The test uses the same testable properties and can be run with: `testMinimalizeBlocks`.

## Findings

We found that the maximum number of empty blocks in a Sudoku problem is 4. This was due to the outcome of he generator we implemented and [this](http://puzzling.stackexchange.com/questions/309/what-is-the-maximum-number-of-empty-3x3-blocks-a-proper-sudoku-can-have) post where 'Emrakul' provides an answer.

In short: When you have an empty block, you are able to solve at most 3 positions when 3 out of 4 related blocks are not empty (horizontally or vertically). With a Sudoku where 5 blocks are empty (no matter the distribution), each empty block has too many related blocks that are empty as well.

> The related blocks are the blocks that are in the same row or column as the subject block.

As 'Emrakul' also shows, there are cases where it is possible to have 4 empty blocks (as our generator shows).
