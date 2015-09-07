# Test report for Triangles

## Source

The source can be found in the file: `TrianglesTest.hs`.

## Requirements

> Write a program (in Haskell) that takes a triple of integer values as arguments and gives as output one of the following statements:
> 
> - `Not a triangle` (Geen driehoek) if the three numbers cannot occur as the lengths of the sides of triangle,
> - `Equilateral` (Gelijkzijdig) if the three numbers are the lengths of the sides of an equilateral triangle,
> - `Rectangular` (Rechthoekig) if the three numbers are the lengths of the sides of a rectangular triangle,
> - `Isosceles` (Gelijkbenig) if the three numbers are the lengths of the sides of an isosceles (but not equilateral) triangle,
> - `Other` (Anders) if the three numbers are the lengths of the sides of a triangle that is not equilateral, not rectangular, and not isosceles.

## Postconditions

- Let all three sides be equal, than the result of the `triangle` function should be an `Equilateral`.
- When we have a `Equilateral` and change one side, we either end up with a `Isosceles` or a `NoTriangle`.
- When we have an `a`, `b` and `c` that comply to Pythagoras, the triangle is `Rectangular`.
- When we have a `Rectangular` triangle and change one side, we end up with a shape that is not a `Rectangular`.

## Tests

We applied different approaches to test the implementation

### Base Cases

We tested some of the base cases which exploit the base properties of each shape and in addition added some cases that are not a triangle. These 'NoTriangle' cases are:

- Triangles where `a + b <= c`. It is not possible to draw these triangles.
- Triangles where at least one side is `0`. When trying to draw these, you end up with a single line.
- Negative numbers. A triangle side which is negative is considered undrawable.

The base cases can be executed with the following command:

```
testBaseCases
```





