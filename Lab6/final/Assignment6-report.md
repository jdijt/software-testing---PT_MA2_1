# Report Assignment 6

### Test Carmichael Numbers with the Miller-Rabin Primality Check

For this exercise we have tested the for primality on Carmichael numbers using the Miller-Rabin primality check.

We found that the chance that Miller-Rabin passes on a Carmichael number was much lower than when we were using the Fermat's primality check, but it is still not full proof.

For a certain `k` we tested the Miller-Rabin primality check with the first 100 Carmichael numbers. We repeated this 100 times and computed the average number of Carmichael numbers that pass the test. The results are stated in the table below:

| `k`  | Average passing Carmichael numbers <small>(out of 100)</small> |
| ---- | -------|
|  1   | ~10    |
|  2   | ~1     |
|  3   | ~0.1   |
|  4   | ~0.02  |

The average of numbers that fool the Miller-Rabin test seems to decrease by a factor that is near 10, but we were not able verify this property.

### Use Miller-Rabin Primality Check to Generate Mersenne Primes

We implemented a generator for Mersenne primes in the `Assignment6.hs` module. The generated Mersenne primes match the provided Mersenne primes on the dedicated [Wikipedia][1] page and the provided primes of the Lecture (m1, m2, ...). Therefor we conclude that the list we generate is correct.


[1]:https://en.wikipedia.org/wiki/Mersenne_prime
