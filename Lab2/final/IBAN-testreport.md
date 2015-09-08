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

We applied one test for valid IBAN numbers and one for invalid IBAN numbers.

### Valid IBAN test

We took 6 IBAN numbers from different countries from a list with known valid IBAN numbers. The function `iban` should always return `True`.

The valid IBAN test can be executed with the following command:

```
basicTest
```

### Invalid IBAN test

We took the same 6 valid IBAN numbers and swapped two characters, which ensures the adapted IBAN number is invalid and replicates the effect of human made typo's. The characters which are swapped should not be the same or include non-alphabetical characters as in this case the adapted IBAN number equals the original number.

The invalid IBAN test can be executed with the following command:

```
testFalse iban genRandomTransposition
```
