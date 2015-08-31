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
testToRevDigits (n, xs) = toRevDigits n == xs

ex2Tests :: [Test]
ex2Tests = [Test "toRevDigitsTest" testToRevDigits
			[(1234, [4,3,2,1]), --Case from the assignment
			(0,[]),				--Case from the assignment
			((-17),[]),			--Case from the assignment
			(2000,[0,0,0,2])]	--Zeroes should work as well.
			]

-- Exercise 3 -----------------------------------------

testDoubleEveryOther :: ([Integer],[Integer]) -> Bool
testDoubleEveryOther (xs,ys) = doubleEveryOther xs == ys

ex3Tests :: [Test]
ex3Tests = [Test "doubleEveryOtherTest" testDoubleEveryOther
			[([],[]),				--BaseCase 1
			([1],[1]),				--BaseCase 2
			([1,2],[1,4]),			--short list
			([1,2,1,2],[1,4,1,4])]	--long list
			]

-- Exercise 4 -----------------------------------------

testSumDigits :: ([Integer],Integer) -> Bool
testSumDigits (xs,r) = sumDigits xs == r

ex4Tests :: [Test]
ex4Tests = [Test "toSumDigitsTest" testSumDigits
			[([],0),
			([0],0),
			([1,1],2),
			([11],2),
			([1,11],3)]
			]

-- Exercise 5 -----------------------------------------

testLuhn :: (Integer,Bool) -> Bool
testLuhn (x,r) = luhn x == r

ex5Tests :: [Test]
ex5Tests = [Test "luhnTest" testLuhn
			[(0,True),
			(42,True),
			(24,False),
			(43,False)]
			]

-- Exercise 6 -----------------------------------------

ex6Tests :: [Test]
ex6Tests = []

-- All Tests ------------------------------------------

allTests :: [Test]
allTests = concat [ ex1Tests
                  , ex2Tests
                  , ex3Tests
                  , ex4Tests
                  , ex5Tests
                  , ex6Tests
                  ]
