module IBANTest where


import IBAN
import System.Random
import Data.Char

validIbans :: [String]
validIbans = ["NL39 RABO 0300 0652 64",						-- Dutch
				"LI21 0881 0000 2324 013A A",				-- Liechtenstein
				"MT84 MALT 0110 0001 2345 MTLC AST0 01S",	-- Malta
				"AT61 1904 3002 3457 3201",					-- Austria
				"FR14 2004 1010 0505 0001 3M02 606",		-- France
				"QA58 DOHB 0000 1234 5678 90AB CDEF G"]		-- Qatar


basicTest :: Bool
basicTest = all (==True) $ map iban validIbans


-- From lecture 2.
getRandomInt :: Int -> IO Int
getRandomInt n = getStdRandom (randomR (0,n))


genRandomTransposition :: String -> IO String
genRandomTransposition s = do
		x <- getRandomInt (length s - 2) -- Minus two because we swap x and x+1
		if validTransposition (s !! x) (s !! (x+1))	then 
			return $ transPoseAtIndex s x
		else 
			genRandomTransposition s
		where
		--Transposition is valid if chars are not equal and no space (if this is the case it does not corrupt the iban to cause a failure)
		validTransposition :: Char -> Char -> Bool
		validTransposition a b = not (isSpace a || isSpace b || a == b)

		transPoseAtIndex :: String -> Int -> String
		transPoseAtIndex [] _ = []
		transPoseAtIndex [x] _ = [x]
		transPoseAtIndex (x:y:xs) 0 = (y:x:xs)
		transPoseAtIndex (x:xs) n = x:transPoseAtIndex xs (n-1);
		

addRandomChar :: String -> [Char] -> IO String
addRandomChar s cs = do		
		x <- getRandomInt (length cs - 1)
		idx <- getRandomInt (length s - 1)
		return $ insertCharAtIndex s (cs !! x) idx
		where
		insertCharAtIndex :: String -> Char -> Int -> String
		insertCharAtIndex [] c _ = [c]
		insertCharAtIndex (x:xs) c 0 = (x:c:xs)
		insertCharAtIndex (x:xs) c n = x:insertCharAtIndex xs c (n-1)

addRandomAlphaNumChar :: String -> IO String
addRandomAlphaNumChar s = addRandomChar s "ABCDEFGHIJKLMNOPQRTUVWXYZ1234567890"

addRandomNonAlphaNumChar :: String -> IO String
addRandomNonAlphaNumChar s = addRandomChar s "!@#$%&^ " 



testF :: Int -> Int -> (String -> Bool) -> (String -> IO String) -> Bool -> IO ()
testF k n f e p
	| k == n    =  print (show n ++ " tests passed")
	| otherwise = do
		ib <- e $ validIbans !! (k `mod` 6)  --Get corrupted IBAN.
		if iban ib == p then 
			do	print ("pass on: " ++ show ib ++ " Original: " ++ (validIbans !! (k `mod` 6)))
				testF (k+1) n f e p
		else error ("failed test on: " ++ show ib ++ " Original: " ++ (validIbans !! (k `mod` 6)))
		 
testFalse :: (String -> Bool) -> (String -> IO String) -> IO ()
testFalse f e = testF 1 100 f e False

testTrue :: (String -> Bool) -> (String -> IO String) -> IO ()
testTrue f e = testF 1 100 f e True
