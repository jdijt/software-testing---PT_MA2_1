# Test report for Assignment 5

The total amount of time spent by two persons on this Lab exercise is 8 hours.

## Source

The source can be found in the files `Assignment5.hs` and `Assignment5Test.hs`. Please load `Assignment5Test`. This will also load the `Parse` source.

The subject of matter in the function `cnf2cls`.

## Test Generator

The test generator can be found in `Assignment5Test` and has the form `Arbitrary Form`. We used QuickCheck to create the data structures that are conform to the Conjunctive Normal Form (CNF).

We maximized the size of the formulas to:

- At most 10 properties within a conjunction or disjunction
- At most 10 disjunctions within a conjunction

## Test Properties

The test properties that we have identified on the `cnf2cls` function:

- `prop_clausesLength` This properties checks that the length of the conjuncts in the CNF is equal to the number of `Clause`s.
- `prop_clauseLength` This property checks that the length of each conjunct is equal to the length of each `Clause`.
- `prop_nameSumEqual` This property checks if the sum of all propositions or negated propositions match the sum of all `Clause` values.

## Test Process

Each property mentioned in the previous exercise is tested one hundred times.
The generator made sure that all generated `Form` instances are in CNF, which gives us 100% test relevance. Therefor we assume that 100 tests is enough to validate the properties.

All properties can be tested with a single command:

```
quickCheck test_cnf2cls
```
