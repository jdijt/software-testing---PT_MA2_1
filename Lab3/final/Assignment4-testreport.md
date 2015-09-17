# Test report for the `toCNF` function
The total amount of time spent by two persons on this Lab exercise is 10 hours

## Source

The source can be found in the file `Assignment4.hs`. Please load with `:load Assignment4`. This will also load all necessary libraries and files.

## Requirements

> Write a formula generator for random testing of properties to test the correctness `toCNF` function of Assignment 3. 

## Preconditions 

The preconditions for `toCNF` are: 
- A valid proposition containing possibly properties, negations, conjunctions, disjunctions, implications and equivalences 

## Postconditions

- A valid proposition in the conjunctive normal form, which is logically equivalent to the input of the `toCNF` function

## Tests
We perform a test to check two different characteristics of the `toCNF` function. First we check whether the output of the `toCNF` function is logically equivalent to its input and furthermore we check whether the output is in the Conjunctive Normal Form.

### Random proposition test

The random valid propositions are generated as a tree of a random size. The tree has a maximum of three layers of nodes including the top-node. All leaves of the tree exist of properties and all conjunction and disjunctions contain between zero and three propositions, which is defined in the functions `randomForm` and `randomForm'`.

These random propositions are converted to the Conjunctive Normal Form with the `toCNF` function, to check whether the output and input are logically equivalent we evaluate the truth tables from the input proposition with both the input and the output and check whether they give the same result.

### Conjunctive Normal Form test

A proposition in the Conjunctive Normal Form can exist of a property, a negation wrapped around a property, a disjunction consisting of properties and negations and a conjunction existing of properties, negations and disjunctions. We use these characteristics in the function `isInCNF` which is also tested in the `randomPropTest`. 

Both properties can be tested with the following comment:
```
quickCheck randomPropTest
```
