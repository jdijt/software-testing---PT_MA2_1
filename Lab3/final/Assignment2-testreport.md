# Test report for parsing propositional formulas
The total amount of time spent by two persons on this Lab exercise is 9 hours

## Source

The source can be found in the file `Assignment2.hs`. Please load with `:load Assignment2`. This will also load all necessary libraries.

## Requirements

> Write a test for parsing propositional formulas

## Preconditions

- A string containing only (,),*,+,-,==>,<=>, spaces or digits, when the input includes other symbols an exception is thrown. We call strings that do not match this criteria invalid strings.

## Postconditions

Strings that are not parsable should return an empty parse result. 
Strings are parsable if:
 
- All + or * should be followed by an opening parentheses, any number of valid propositions and a closing parentheses
- All - should be followed by a valid proposition 
- All ==> and <=> should be within parentheses and have one valid proposition before and after the token 
- All symbols after the final closing brackets should be ignored

## Tests
We apply two tests, one based on a set of base cases and one based on randomly generated valid propositions.

### Base cases
- We take 6 non-parsable strings and check whether the parse function returns an empty result.
- We take one parsable string for each kind of proposition and check whether the parse function returns the correct form. 

The basic parse test can be executed with the following command:

```
basicParseTest
```

### Random valid proposition test
We generate 100 valid parsable forms and check whether the parsed results are the same as the generated forms.
We start by generating a property which is a random integer between 0 and 9 and use this in one of the following functions:

- generateNeg, create a negation of the given form
- generateCnj, create a conjuction of the given form and another random property
- generateDsj, create a disjuction of the given form and another random property
- generateImpl, create an implication of the given form and another random property
- generateEquiv, create an equivalence of the given form and another random property

The function that we use is randomly chosen with equal probabilities. There is a change of 0.5 that the whole generateValidForm function will be applied on the resulting form. Note that this function could be replaced by a QuickCheck test using a valid proposition generator, we implement this in Assignment 4 in the function `randomForm`

The random valid proposition test can be executed with the following command:
```
testValidForms
```
