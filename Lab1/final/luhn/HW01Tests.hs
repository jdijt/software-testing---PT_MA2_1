-- CIS 194, Spring 2015
--
-- Test cases for HW 01

module HW01Tests where

import HW01
import Testing

-- Exercise 1 -----------------------------------------

testLastDigit :: (Integer, Integer) -> Bool
testLastDigit (n, d) = lastDigit n == d

testDropLastDigit :: (Integer, Integer) -> Bool
testDropLastDigit (n, d) = dropLastDigit n == d

ex1Tests :: [Test]
ex1Tests = [ Test "lastDigit test" testLastDigit
             [(123, 3), (1234, 4), (5, 5), (10, 0), (0, 0)]
           , Test "dropLastDigit test" testDropLastDigit
             [(123, 12), (1234, 123), (5, 0), (10, 1), (0,0)]
           ]

-- Exercise 2 -----------------------------------------
testToRevDigits :: (Integer, [Integer]) -> Bool
testToRevDigits (n, d) = toRevDigits n == d


ex2Tests :: [Test]
ex2Tests = [ Test "toRevDigits test" testToRevDigits
             [(1, [1]),             --Base Case
             (1234, [4, 3, 2, 1]),  --Case from the assignment
             (0,[]),				--Case from the assignment
             ((-17),[]),			--Case from the assignment
             (2000,[0,0,0,2])]	    --Zeroes should work as well.
           ]


-- Exercise 3 -----------------------------------------
testDoubleEveryOther :: ([Integer], [Integer]) -> Bool
testDoubleEveryOther (x,y) = doubleEveryOther x == y

ex3Tests :: [Test]
ex3Tests = [ Test "doubleEveryOther test" testDoubleEveryOther
             [([],[]),				        --BaseCase 1
             ([1],[1]),				        --BaseCase 2
             ([1, 2, 3], [1, 4, 3]),        --short list
             ([1, 2, 3, 4], [1, 4, 3, 8]),  --long list
             ([0, 0], [0, 0])               --Case from the assignment
             ]
           ]

-- Exercise 4 -----------------------------------------
testSumDigits :: ([Integer], Integer) -> Bool
testSumDigits (i,o) = sumDigits i == o

ex4Tests :: [Test]
ex4Tests = [ Test "sumDigits test" testSumDigits
             [([1, 2, 3], 6),       --Short list
             ([10, 5, 18, 4], 19),  --Case from the assignment
             ([], 0), ([0], 0),     --Sum of empty list
             ([0],0),               --Case with zero
             ([1,11],3)             --Case with double digits
             ]
           ]

-- Exercise 5 -----------------------------------------
testLuhn :: (Integer, Bool) -> Bool
testLuhn (i, o) = luhn i == o

ex5Tests :: [Test]
ex5Tests = [ Test "luhn test" testLuhn
             [(5594589764218858, True), --Case from the assignment
             (1234567898765432, False), --Case from the assignment
             (378282246310005, True),   --Real credit card
             (378734493671000, True),   --Real credit card
             (5262703537271091, True),
             (1255125512551255, True),
             (5262703537271093, False),
             (0, True),
             (810, True),
             (910, False),
             (24,False),
             (42,True),
             (43,False)
             ]
           ]

-- All Tests ------------------------------------------

allTests :: [Test]
allTests = concat [ ex1Tests
                  , ex2Tests
                  , ex3Tests
                  , ex4Tests
                  , ex5Tests
                  ]