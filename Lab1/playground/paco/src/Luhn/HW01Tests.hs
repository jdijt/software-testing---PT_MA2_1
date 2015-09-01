-- CIS 194, Spring 2015
--
-- Test cases for HW 01

module Luhn.HW01Tests where

import Luhn.HW01
import Luhn.Testing

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
ex2Tests = [ Test "toRevDigits" testToRevDigits
            [(230, [0,3,2]), (1234, [4,3,2,1]), (-1, []), (0, [])]
           ]

-- Exercise 3 -----------------------------------------
testDoubleEveryOther :: ([Integer], [Integer]) -> Bool
testDoubleEveryOther (n, d) = doubleEveryOther n == d

ex3Tests :: [Test]
ex3Tests = [ Test "doubleEveryOther" testDoubleEveryOther
                [
                     ([1,2,3], [1,4,3]),
                     ([], []),
                     ([-1], [-1]),
                     ([0], [0]),
                     ([1,2], [1,4]),
                     ([9,8,7,8,9], [9, 16, 7, 16, 9])
                ]
           ]

-- Exercise 4 -----------------------------------------
testSumDigits :: ([Integer], Integer) -> Bool
testSumDigits (n, d) = sumDigits n == d

ex4Tests :: [Test]
ex4Tests = [ Test "sumDigits" testSumDigits
                           [
                                ([1,2,3], 6),
                                ([], 0),
                                ([-1], -1),
                                ([0], 0),
                                ([1,2], 3),
                                ([9,8,7,8,9], 41),
                                ([19,118], 20)
                           ]
                      ]

-- Exercise 5 -----------------------------------------

testLuhn :: (Integer, Bool) -> Bool
testLuhn (n, d) = luhn n == d

ex5Tests :: [Test]
ex5Tests =  [ Test "luhn" testLuhn
                [
                   (5594589764218858, True),
                   (1234567898765432, False),
                   (5262703537271091, True),
                   (1255125512551255, True),
                   (5262703537271093, False)
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