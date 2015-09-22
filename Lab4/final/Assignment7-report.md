# Test report for Assignment 7

## Source
The source is located in the file `Assignment7.hs`, which includes the source from Assignment 5 and 6 (`Assignment5.hs` and `Assignment6.hs`).

*Note that the file `Assignment7.hs` contains a usage of the `sublistOf` function which requires QuickCheck version 2.8 or higher.*

## Pre/Postconditions
Pre- and postconditions per function.

### Shared conditions:
Some pre- and postconditions are shared between `symClos` and `trClos`, these are the following.

*Preconditions*
- Input is some ordered list of pairs.

*Postconditions*
- Output is an ordered list of pairs. (In natural ordering)
- The input is a subset of the output
- There are no duplicates in the output

### Symmetric closure
The shared conditions plus the following postcondition:
- The result is a symmetric relation: for each (x,y) in the result, there also exists (y,x) in the result.  


### Transitive closure
The shared conditions plus the following postcondition:
- The result is a transitive relation: for each (x,y) and (y,z) in the result, there also exists (x,z) in the result.

## Tests

### Symmetric closure test
This tests checks whether the postconditions described above hold. The test can be executed with:
 `quickCheck symClosTest`
 
### Transitive closure test
This tests checks whether the postconditions described above hold. The test can be executed with:
 `quickCheck trClosTest`