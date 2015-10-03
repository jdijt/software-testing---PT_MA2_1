# Assignment 6

> Can you find a way of classifying the difficulty of a Sudoku problem? 

> Can you modify the Sudoku problem generator so that it can generate problems that are minimal, but easy to solve by hand? Problems that are minimal but hard to solve by hand? 

> How can you test whether the problems your program generates satisfy these properties? Consult (Pelánek 2014).


## Classifying difficulty 

The algorithm we use to determine the difficulty is based on the number of available numbers a user can place in a single field.
We have modified the existing minimalize algorithm to only remove numbers if there are n values available.

The minimalize function takes a list of coordinates. For each coordinate we remove te value and then check how many values are available by checking the constraint for the given coordinate:
`numberPossibleVal = length (getThird (findConstraint r c (snd n')))`

If `numberPossibleVal` is lower or equal to n, we remove the value and continue with the next value.

In order to find out more about the difficulty of the generated puzzle we determined a metric:
- When removing a field, store the number of available values in a list. Then take the sum of this list.

When analyzing the result of the generation process we noticed the following:
- After reaching n = 4 the difficulty hardly increases (see test results)
- A higher score doesn't necessary means that user had to make more assumptions for a field, it could also be that more fields with a lower number of possible values were removed
- the score can fluctuate a lot, this is because we start with a random puzzle

Based on this we state the following:
- Generating a puzzle with n = 1 would generate an easy puzzle: The puzzle can be completely solved without having to make a single guess.
- Generating a puzzle with n = 9 would generate the hardest possible problem for the given solution
- Generating a puzzle with n > 5 generates problems that are very similar in difficulity as n = 9

We can conclude that there is gliding range where n = 1 represents east and n = 5 represents hard. However because the difficulty fluctuates chances are that you generate a puzzle that is easier then the requested difficulty.



--TODO formatting, style etcetereta markup....


- TestResults


-- > replicateM 10 (main 1) .. TODO : run with 50 
-- [40,41,40,38,37,40,39,41,40,38] 

-- > replicateM 10 (main 2) .. TODO : run with 50 
-- [71,66,66,60,66,60,64,59,68,70]

-- > replicateM 10 (main 3) .. TODO : run with 50 
-- [87,93,81,100,85,96,92,93,87,86]

-- > replicateM 50 (main 4)
-- [118,109,108,107,107,107,107,106,104,104,103,103,103,103,102,102,102,102,101,101,100,100,100,99,99,99,99,99,99,98,98,98,98,97,97,97,97,96,96,96,96,96,96,95,94,94,93,93,91,88] (reversed and sorted)

-- > replicateM 50 (main 5)
-- [124,119,115,115,113,113,113,111,110,110,109,109,108,108,108,107,107,107,107,107,106,106,106,106,105,105,104,104,104,103,103,103,102,102,102,101,101,100,99,99,98,98,97,96,96,95,95,94,89,89] (reversed and sorted)

-- > replicateM 50 (main 6)
-- [126,122,119,117,115,115,112,111,110,110,109,109,109,109,108,108,108,107,107,106,106,106,106,105,105,105,105,105,105,105,104,104,103,103,103,102,102,100,99,99,98,98,97,97,96,96,93,93,92,88] (reversed and sorted)

-- > replicateM 50 (main 7)
-- [119,118,117,117,117,116,114,114,113,113,111,111,111,110,109,109,109,109,109,108,108,107,107,105,105,105,105,105,105,104,104,103,103,102,102,102,102,102,102,102,101,100,100,99,98,98,97,96,93,90] (reversed and sorted)

-- > replicateM 50 (main 8)
-- [121,118,118,117,117,116,116,115,114,114,113,113,112,111,110,110,110,109,108,108,107,107,107,106,106,106,106,105,105,105,104,104,103,103,103,103,102,101,99,99,98,97,97,97,96,96,95,93,93,91] (reversed and sorted)

