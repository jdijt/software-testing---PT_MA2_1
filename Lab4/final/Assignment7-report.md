# Test report for Assignment 7

## Source
The source is located in the file `Assignment7.hs`, which includes the source from Assignment 5 and 6 (`Assignment5.hs` and `Assignment6.hs`).

## Pre/Postconditions
Pre and postconditions per function.

### Symmetric closure
*Preconditions*

- Input is some ordered list of pairs.

*Postconditions*

- Output is an ordered list of pairs. (In natural ordering):
```haskell
    sort xs == xs
```
- There are no duplicates in the output:
```haskell
    (length.nub) xs == length xs
```
- The result is a symmetric relation: 
```haskell
    all (\(x,y) -> (y,x) `elem` rel) rel
```

### Transitive closure

## Tests

### Tests...Tests..Tests..
_And how to run them._
