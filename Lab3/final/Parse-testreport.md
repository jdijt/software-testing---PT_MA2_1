# Test report for parsing propositional formulas
The total amount of time spent by two persons on this Lab exercise is 9 hours

## Source

The source can be found in the files `Parse.hs` and `ParseTest.hs`. Please load `ParseTest` with `:load ParseTest`. This will also load the `Parse` source.

## Requirements

> Write a test for parsing propositional formulas


## Postconditions
A valid proposition P ::= D | -P |   

- All strings containing only (,),*,+,-,==>,<=>, spaces or digits should parse otherwise an exception is thrown. 
We call strings that do not match this criteria invalid strings.

Strings that are valid but not parsable should return an empty parse result. 
Strings are parsable if:
 
- All + or * should be followed by an opening parentheses, any number of valid propositions and a closing parentheses
- All - should be followed by a valid proposition
- All ==> and <=> should be within parentheses and have a proposition before and after the token 

## Tests
We applied two tests, one based on a set of base cases and one based on randomly generated valid propositions.


### Base cases
- We take 6 non-parsable but valid strings and check whether the parse function returns an empty result.
- We take 1 valid parsable string for each kind of proposition and check whether the parse function returns the correct form. 

The basic parse test can be executed with the following command:

```
basicParseTest
```

### Random valid proposition test
We generate 100 valid parsable forms and check whether the parsed results are the same as the generated forms.
We start by generating a property which as a random integer between 0 and 9 and use this in one of the following functions:

- generateNeg, create a negation of the given form
- generateCnj, create a conjuction of the given form and another random property
- generateDsj, create a disjuction of the given form and another random property
- generateImpl, create an implication of the given form and another random property
- generateEquiv, create an equivalence of the given form and another random property

The function that we use is randomly chosen. There is a change of 0.5 that the whole generateValidForm function will be applied on the resulting form.

The random valid proposition test can be executed with the following command:
```
testValidForms
```