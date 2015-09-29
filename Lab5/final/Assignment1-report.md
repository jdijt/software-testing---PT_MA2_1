# Assignment 1

> The goal of this exercise is to extend the Sudoku program described in the lecture of this week with functions that can also handle Sudokus of a special kind: the Sudokus that appear in the Dutch evening newspaper NRC-Handelsblad each week (designed by Peter Ritmeester, from Oct 8, 2005 onward). These NRC Sudokus are special in that they have to satisfy a few extra constraints: in addition to the usual Sudoku constraints, each of the 3×3 subgrids with left-top corner (2,2), (2,6), (6,2), and (6,6) should also yield a surjective function. The above figure gives an example (this is the NRC Sudoku that appeared Saturday Nov 26, 2005).

> Your task is to formalize this extra constraint, and to use your formalization in a program that can solve this Sudoku. See also the webpage of Andries Brouwer.

## Formalized Constraint

### Sudoku Matrix

As formalized in the lecture of week 5 the existing constraints for a Sudoku 9x9 matrix are:

* Every row should contain each number in {1,…,9}
* Every column should contain each number in {1,…,9}
* Every subgrid [i,j] with i,j ranging over 1..3, 4..6 and 7..9 should contain each number in {1,...,9}.

In addition to these constraints, an additional constraint should be added to support the NRC Sudoku:

* Every subgrid [i,j] with i,j ranging over 2..4 and 6..8 should contain each number in {1,...,9}.

### Sudoku Problem

As formalized in the lecture of week 5 the existing constraints for a Sudoku 9x9 problem are:

- The values in every row should be in {1,…,9}, and should all be different.
- The values in every column should be in {1,…,9}, and should all be different.
- The values in every subgrid [i,j] with i,j ranging over 1..3, 4..6 and 7..9 should be in {1,...,9}, and should all be different.

In addition to these constraints, an additional constraint should be added to support the NRC Sudoku:

- The values in every subgrid [i,j] with i,j ranging over 2..4 and 6..8 should be in {1,...,9}, and should all be different.

> We assume that the empty positions do not represent any value other than 0 which is used in the provided Sudoku implementation.
