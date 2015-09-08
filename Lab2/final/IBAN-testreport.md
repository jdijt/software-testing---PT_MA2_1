# Test report for IBAN

## Source

The source can be found in the files `IBAN.hs` and `IBANTest.hs`. Please load `IBANTest` with `:load IBANTest`. This will also load the `IBAN` source.

## Requirements

> Implement a validation procedure for International Bank Account Number (IBAN). The steps are executed by the following functions in `IBAN.hs`
> 
> - Preliminary step: Delete all non-alphanumeric characters in `removeSpaces`
> - Step 1: Move the first four characters (the head) of the IBAN to the right of the number in `moveHeader`
> - Step 2: Convert the letters into numerics in accordance with a conversion table where `A = 10 and Z = 35` in `adaptLetters` and `toDigits`
> - Step 3: Check whether the MOD 97 equals 1 in `iban` 

## Postconditions

- All valid IBAN numbers should return `True`
- All invalid IBAN number should return `False`


## Tests

We applied different approaches to test the implementation. In the following paragraphs when we mention `a`, `b` and `c`, we assume that `a <= b <= c`.

### Base Cases

We tested some of the base cases which exploit the base properties of each shape. In addition we checked the `NoTriangle` property that holds when the triangle sides have the form `a + b <= c`. It is not possible to draw these triangles. This directly implies that triangles with at least one side of `0` or less will be of the class `NoTriangle`.

The base cases can be executed with the following command:

```
testBaseCases
```

### Statistics over a certain domain

We have generated all possible triples over a domain of natural numbers with `3 <= n <= 5` and we determined the number of instances with logic for each class of triangle that should occur in this set. We came to the conclusion that the set should contain (`n` is the size of the domain):

- 3 `Equilateral` triangles (n);
- 18 `Isosceles` triangles (`3 * n (n - 1 )`. *This will only hold for a domain where it is not possible to have triangles of the class `NoTriangle`*);
- and 6 `Rectangular` triangles (`3`, `4`, `5` is the only Pythagoras triangle, which will result in 6 permutations).

The statistics tests can be executed with the following command:

```
testOccurences
```

### Property based tests

We tested properties that we did not use in the definition of the function `triangle`.

- When we change one of the sides of a triangle that would produce an `Equilateral` the result can never result in an `Equilateral`, but has to be an `Isosceles` or a `NoTriangle`. This is tested with `testChangeEquilateral`.
- When we change one of the sides of a triangle that would produce a `Rectangular` the result can never result in a `Rectangular`. This is tested with `testChangeRectangular`.
- When we order of the input, the resulting shape should be the same. This is tested with `testPermutations`.



