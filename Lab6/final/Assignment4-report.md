# Report Assignment 4

## Least Composite Number Failing Fermat's Test

With the code of [`Assignment4.hs`](Assignment4.hs) we found out that the least composite number to fail Fermat's primality test as implemented with `prime_tests_F` is `4`, which actually is the first composite number.

`prime_tests_F` uses a random `a` as base in the formula `a^(n-1) mod n`. We concluded that this test must always fail when `n > 1` and `a = 1`. Then `1^x` will always result in `1` and thus `1 mod n` will result in `1`.

With the composite number `4` the value of `a` will be in the range `[1..3]`, leaving a chance of 1 out of 3 that the Fermat test fails.

In our code we use `minimumFailingFermat k n` to test the Fermat test on composite numbers with a certain `k` and finding the minimal value after `n` executions. When we increase `n` it is more probable that the resulting value is `4`.

From this we can also conclude that the chance of a composite number to fail is:

```
|∀x in N (0 < x < n ^ x^(n-1) mod n == 1)| / (n-1)
```

## Conclusion

Fermat test is likely to fail on composite numbers due to a base value `a = 1` (especially on low composites). When `k` is increased it is less likely to pass the Fermat test with a composite, but still not impossible due do the randomness of `a`.
