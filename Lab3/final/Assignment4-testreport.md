# Test report for testing the `toCNF` function of assignment 3 
The total amount of time spent by two persons on this Lab exercise is 9 hours

## Source

The source can be found in the file `Assignment4.hs`. Please load with `:load Assignment4`. This will also load all necessary libraries and files.

## Requirements

> Write a formula generator for random testing of properties to test the correctness `toCNF` function of Assignment 3. 

## Preconditions 

The preconditions for `toCNF` are: 
- A valid proposition containing possibly properties, negations, conjunctions, disjunctions, implications and equivalences 

## Postconditions

- A valid proposition in the conjunctive normal form which is logically equivalent to the input of the `toCNF` function

## Tests
We apply two test, one to check whether the output of the `toCNF` function is in the Conjunctive Normal Form and one to test whether 
it is logically equivalent to the input of the input 

### Conjunctive Normal Form test

The conjunctive normal form test can be executed with the following command:
```
randomPropTest
```

### Random proposition test

...

The random proposition test can be executed with the following command:
```
randomPropTest
```
