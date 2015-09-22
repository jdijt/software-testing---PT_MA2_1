# Test report for Assignment 7

## Source
The source is located in the file `Assignment7.hs`, which includes the source from Assignment 5 and 6 (`Assignment5.hs` and `Assignment6.hs`).

## Pre/Postconditions
Pre and postconditions per function.

### Shared conditions:
Some pre and postconditions are shared between `symClos` and `trClos`, these are the following.

*Preconditions*
- Input is some ordered list of pairs.

*Postconditions*
- Output is an ordered list of pairs. (In natural ordering):
```haskell
    prop_isOrdered :: Ord a => Rel a -> Bool
    prop_isOrdered xs = sort xs == xs
```
- There are no duplicates in the output:
```haskell
    prop_noDup :: Ord a => Rel a -> Bool
    prop_noDup xs = (length.nub) xs == length xs
```

### Symmetric closure
- The result is a symmetric relation: 
```haskell
    prop_isSym :: Ord a => Rel a -> Bool
    prop_isSym xs = all (\(x,y) -> (y,x) `elem` xs) xs
```

### Transitive closure
- The result is a transitive relation:
```haskell
    prop_isTrans :: Ord a => Rel a -> Bool
    prop_isTrans rs = and [ trans r rs | r <- rs]
        where
        trans :: Ord a => (a,a) -> Rel a -> Bool
        trans (x,y) rs = and [(x,v) `elem` rs | (u,v) <- rs, u == y]
```

## Tests

### Tests...Tests..Tests..
_And how to run them._
