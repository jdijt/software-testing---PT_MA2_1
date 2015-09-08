module IBANTest where


import IBAN
import System.Random

validIbans :: [String]
validIbans = ["NL39 RABO 0300 0652 64",						-- Dutch
				"LI21 0881 0000 2324 013A A",				-- Liechtenstein
				"MT84 MALT 0110 0001 2345 MTLC AST0 01S",	-- Malta
				"AT61 1904 3002 3457 3201",					-- Austria
				"FR14 2004 1010 0505 0001 3M02 606",		-- France
				"QA58 DOHB 0000 1234 5678 90AB CDEF G"]		-- Qatar


basicTest :: Bool
basicTest = all (==True) $ map iban validIbans

