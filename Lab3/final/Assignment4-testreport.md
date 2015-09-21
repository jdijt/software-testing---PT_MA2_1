# Test report for the `toCNF` function
The total amount of time spent by two persons on this Lab exercise is 10 hours.

## Source

The source can be found in the file `Assignment4.hs`. Please load with `:load Assignment4`. This will also load all necessary libraries and files.

## Requirements

> Write a formula generator for random testing of properties to test the correctness of the `toCNF` function of Assignment 3.

## Preconditions

The preconditions for `toCNF` are:
- A valid proposition containing possibly properties, negations, conjunctions, disjunctions, implications and equivalences

## Postconditions

- A valid proposition in the Conjunctive Normal Form, which is logically equivalent to the input of the `toCNF` function

## Tests
We perform a test to check two different properties of the `toCNF` function. First we check whether the output of the `toCNF` function is logically equivalent to its input and furthermore we check whether the output is in the Conjunctive Normal Form.

### Equivalence
To check whether the output and input are logically equivalent we first generate all possible valuations with the provided `allVals` function. We then evaluate all possible valuations with both the input and the output of the `toCNF` function and check whether the resulting truth tables are equal. 

### Conjunctive Normal Form
A proposition in the Conjunctive Normal Form can exist of either:
 
- a property 
- a negation wrapped around a property 
- a disjunction consisting of properties and negations wrapped around a property
- a conjunction existing of properties, negations wrapped around a property and disjunctions

We use these characteristics in the function `isInCNF` which is also used by the `randomPropTest`.

### Test data generation
The random valid propositions are generated as a tree with a maximum of three layers of nodes including the top-node. All leaves of the tree exist of properties and all conjunctions and disjunctions contain between zero and three propositions. The generation of random propositions is defined in the functions `randomForm` and `randomForm'`. 

These random propositions are converted to the Conjunctive Normal Form with the `toCNF` function.

Both properties described in the above sections can be tested with the following command:
```
quickCheck randomPropTest
```
