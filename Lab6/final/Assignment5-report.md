# Report Assignment 5

## The Fermat Test and Carmichael numbers.
The wikipedia article on the Fermat Primality Test ([Link][1] accessed 07-10-2015) states the following about Carmichael numbers.

>  For these numbers, repeated application of the Fermat primality test performs the same as a simple random search for factors and may be much less likely to determine that n is composite and performs the same as a simple random search for factors.

With some further analysis, using the Carmichael number 294409, this behaviour can also be seen in practice.
The Carmichael numbers must have at least 3 positive prime factors. For 294409 these are 37, 73 and 109.
```
*Assignment5 Data.List> factors 294409
[37,73,109]
```

Running the Fermat primality test for all possible values of `a` and filtering for values that cause the number to fail the test results in the following list.
Notice that all numbers in the list are multiples of the prime factors of 294409. In total there are 14473 `a`. The chances of one of these `a` in the fermat test is small.

This behaviour matches with the statement from the wikipedia article, that it performs the same as a random search for factors.
```
*Assignment5 Data.List> filter (\a -> exM a (294409-1) 294409 /= 1) [1..294409]
[37,73,74,109,111,146,148,185,218,219,222,259,292,296,327,333,365,370,407,436,438,
444,481,511,518,545,555,584,592,629,654,657,666,703,730,740,763,777,803,814,851,872,
876,888,925,949,962,981,999,1022,1036,1073,1090,1095,1110,1147,1168,1184,1199,1221,1241,
1258,1295,1308,1314,1332,1369,1387,1406,1417,1443,1460,1480,1517,1526,1533,1554,1591,
-- etc..
*Assignment5 Data.List> length $ filter (\a -> exM a (294409-1) 294409 /= 1) [1..294409]
14473
```


In addition to the above we also ran some tests to measure the chance of detecting a Carmichael number. See the file [`Assignment5.hs`](Assignment5.hs) for the source.

We have done several runs of the function `countDetectedNumbers`. This function runs the first 100 numbers from the list `carmichael` trough the fermat test for 1 to n iterations.

this gives the following result:( `(iterations,non-primes detected)`).
```
*Assignment5> countFermatFailures 50
[(50,7),(49,5),(48,5),(47,4),(46,4),(45,4),(44,6),(43,3),(42,7),(41,3),(40,2),(39,3),(38,4),(37,3),(36,3),(35,3),(34,3),(33,2),(32,4),(31,2),(30,2),(29,2),(28,3),(27,3),(26,1),(25,1),(24,3),(23,1),(22,2),(21,4),(20,0),(19,2),(18,1),(17,1),(16,2),(15,2),(14,0),(13,1),(12,2),(11,0),(10,1),(9,1),(8,0),(7,0),(6,2),(5,2),(4,1),(3,0),(2,0),(1,0)]
```

## Conclusion
The Fermat test is not suited for detecting Carmichael numbers as composite numbers. Even with a larger amount of iterations it is unlikely a Carmichael number is marked as a composite number.


[1]: https://en.wikipedia.org/wiki/Fermat_primality_test#Flaw
