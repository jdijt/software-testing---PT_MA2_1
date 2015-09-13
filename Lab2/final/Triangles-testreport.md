# Test report for Triangles
Total time spent by two persons on this Lab exercise: 8 hours

## Source

The source can be found in the files `Triangles.hs` and `TrianglesTest.hs`. Please load `TrianglesTest` with `:load TrianglesTest`. This will also load the `Triangles` source.

## Requirements

> Write a program (in Haskell) that takes a triple of integer values as arguments and gives as output one of the following statements:
>
> - `Not a triangle` if the three numbers cannot occur as the lengths of the sides of triangle,
> - `Equilateral` if the three numbers are the lengths of the sides of an equilateral triangle,
> - `Rectangular` if the three numbers are the lengths of the sides of a rectangular triangle,
> - `Isosceles` if the three numbers are the lengths of the sides of an isosceles (but not equilateral) triangle,
> - `Other` if the three numbers are the lengths of the sides of a triangle that is not equilateral, not rectangular, and not isosceles.

## Postconditions

- The result should be a member of the set `{NoTriangle, Equilateral, Isosceles, Rectangular, Other}`.
- The result should return the correct triangle based on the given input in relation with the above requirements.
- When we have a `Equilateral` and change one side, we either end up with a `Isosceles` or a `NoTriangle`.
- When we have an `a`, `b` and `c` that comply to Pythagoras, then the triangle is `Rectangular`.
- When we have a `Rectangular` triangle and change one side, we end up with a shape that is not a `Rectangular`.


## Tests

We applied different approaches to test the implementation. In the following paragraphs when we mention `a`, `b` and `c`, we assume that `a <= b <= c`.

### Base Cases

We tested some of the base cases which exploit the base properties of each shape. In addition we checked the `NoTriangle` property that holds when the triangle sides have the form `a + b <= c`. It is impossible to draw these triangles. This directly implies that triangles with at least one side of `0` or less will be of the class `NoTriangle`, since `a <= b <= c`.

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
testOccurrences
```

### Property based tests

We tested properties that we did not use in the definition of the function `triangle`.

- When we change one of the sides of a triangle that would produce an `Equilateral` the result can never result in an `Equilateral`, but has to be an `Isosceles` or a `NoTriangle`. This is tested with `testChangeEquilateral`.
- When we change one of the sides of a triangle that would produce a `Rectangular` the result can never result in a `Rectangular`. This is tested with `testChangeRectangular`.
- When we order of the input, the resulting shape should be the same. This is tested with `testPermutations`.
