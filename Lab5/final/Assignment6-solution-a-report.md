# Assignment 6 - solution A

Total time spent on this assignment by 2 persons is 18 hours.

## The exercise

> Can you find a way of classifying the difficulty of a Sudoku problem? 

> Can you modify the Sudoku problem generator so that it can generate problems that are minimal, but easy to solve by hand? Problems that are minimal but hard to solve by hand? 

> How can you test whether the problems your program generates satisfy these properties? Consult (Pelánek 2014).

Note: The research was done within limited time, it contains rough assumptions and the test data fluctuates a lot with each run. 

## Classifying difficulty 

The algorithm we use to determine the difficulty is based on the number of available values a user can place in a single field.

We hook our algorithm on the `minimalize` function and check when a field is removed how many values there are available for the removed field.
For example: given the following partial puzzle:

| 1 | 2 | 3 ||  
| 4 | 5 | 6 ||  
| 7 | 8 | 9 ||

1. When removing the value 5 on coordinate (2,2) there is only 1 value possible: 5
2. When removing the value 6 on coordinate (2,3) there now are 2 values possible: 5 and 6

Assuming the user starts with the last field that is removed<sup>1</sup> the field (2,3) (2 options) is harder to solve than the field (2,2) (1 option)

<sup>1</sup> This is a really strong assumption.

We classify the difficulty by taking the sum of values that are available per removed field at the time of removal. The above example would result in a difficulty of 3.
The next assumption we make is that removing 2 fields with 2 possible values each (total 4) is just as difficult as 1 field with 4 possible values. In both cases the user has a total of 4 options to pick from.

We can now say that the higher the number the harder the puzzle.

## Generating problems
We have modified the existing `minimalize` function to only remove a field if there are less than or equal to `n` possible values. Where `n` is a parameter of the generation process.

The `minimalize` function takes a list of coordinates. For each coordinate we remove the value and then check how many values are available by checking the constraint for the given coordinate:
`numberPossibleVal = length (getThird (findConstraint r c (snd n')))`

If `numberPossibleVal` is less than or equal to `n`, we continue with the current state, otherwise we take the previous state with the field still filled in.

In order to find out more about the difficulty of the generated puzzle we used the metric described above:
> When removing a field, store the number of available values in a list. Then take the sum of the resulting list.

The results for the different runs are shown in the table below:

| n | Max | Min | Average |
|---|-----|-----|---------|
| 1 | 43  | 33  | 38      |
| 2 | 75  | 58  | 66      |
| 3 | 102 | 75  | 87      |
| 4 | 118 | 88  | 99      |
| 5 | 124 | 89  | 104     |
| 6 | 126 | 88  | 105     |
| 7 | 131 | 84  | 106     |
| 8 | 121 | 91  | 106     |
| 9 | 130 | 91  | 105     |

When analyzing the result of the generation process we noticed the following:

- After reaching n = 5 the difficulty hardly increases
- The test results fluctuate a lot, this is because we start with a random puzzle  

Based on this we state the following:

- Generating a puzzle with n = 1 would generate an easy puzzle: The puzzle can be completely solved without having to make a single guess.
- Generating a puzzle with n = 9 would generate the hardest possible problem for the given solution
- Generating a puzzle with n > 5 generates problems that are very similar in difficulty as n = 9

We now conclude that there is gliding range where n = 1 represents easy and n = 5 represents hard.   
However because the difficulty fluctuates chances are that you generate a puzzle that is easier then the requested difficulty. This is also visible in the testresults below.

### Raw TestResults
The generation is run 50 times with replicateM for each n in [1..9]. The results are sorted in reversed order.

`> replicateM 50 (main 1)`
`[43,42,41,41,41,41,40,40,40,40,40,40,40,40,40,39,39,39,39,39,39,39,39,38,38,38,38,38,38,38,37,37,37,37,37,37,37,37,37,36,36,36,36,36,35,35,34,34,34,33]`  
Max: 43, Min: 33, Average: 38 


`> replicateM 50 (main 2)`
`[75,73,73,72,72,71,71,70,70,70,70,69,69,69,69,68,68,68,68,67,67,67,67,67,67,67,67,66,65,65,65,65,65,65,64,64,64,64,64,63,63,63,62,62,62,61,61,60,60,58]`  
Max: 75, Min: 58, Average: 66

`> replicateM 50 (main 3)`
`[102,96,95,94,94,92,92,92,92,92,91,91,91,91,91,90,90,90,90,90,89,89,88,88,88,87,86,86,86,85,85,84,84,84,84,84,84,84,83,83,83,83,82,81,81,80,79,79,75,75]`  
Max: 102, Min: 75, Average:87


`> replicateM 50 (main 4)`
`[118,109,108,107,107,107,107,106,104,104,103,103,103,103,102,102,102,102,101,101,100,100,100,99,99,99,99,99,99,98,98,98,98,97,97,97,97,96,96,96,96,96,96,95,94,94,93,93,91,88]`  
Max: 118, Min: 88, Average: 99


`> replicateM 50 (main 5)`
`[124,119,115,115,113,113,113,111,110,110,109,109,108,108,108,107,107,107,107,107,106,106,106,106,105,105,104,104,104,103,103,103,102,102,102,101,101,100,99,99,98,98,97,96,96,95,95,94,89,89]`  
Max: 124, Min: 89, Average: 105


`> replicateM 50 (main 6)`
`[126,122,119,117,115,115,112,111,110,110,109,109,109,109,108,108,108,107,107,106,106,106,106,105,105,105,105,105,105,105,104,104,103,103,103,102,102,100,99,99,98,98,97,97,96,96,93,93,92,88]`  
Max: 126, Min: 88, Average: 105


`> replicateM 50 (main 7)`
`131,124,122,120,120,119,118,116,116,115,113,113,112,111,110,110,108,108,108,107,107,107,107,106,106,106,106,106,105,104,103,103,103,103,103,102,102,101,101,101,101,99,99,98,97,96,95,94,92,84]`  
Max: 131, Min: 84, Average: 106


`> replicateM 50 (main 8)`
`121,118,118,117,117,116,116,115,114,114,113,113,112,111,110,110,110,109,108,108,107,107,107,106,106,106,106,105,105,105,104,104,103,103,103,103,102,101,99,99,98,97,97,97,96,96,95,93,93,91]`  
Max: 121, Min: 91, Average: 106


`\> replicateM 50 (main 9)`
`130,120,115,113,113,112,112,112,111,111,110,110,110,109,109,109,109,108,108,107,107,107,107,107,107,106,106,106,106,106,105,105,104,104,103,103,103,102,101,99,99,98,98,98,98,98,96,95,93,91]`  
Max: 130, Min: 91, Average:105


## Testing the difficulty
-- We didn't manage to solve this in the current solution. Solution B did solve this problem.
