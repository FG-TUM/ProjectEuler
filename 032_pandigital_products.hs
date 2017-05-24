-- We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n
-- exactly once; for example, the 5-digit number, 15234, is 1 through 5 pandigital.
--
-- The product 7254 is unusual, as the identity, 39 × 186 = 7254, containing multiplicand,
-- multiplier, and product is 1 through 9 pandigital.
--
-- Find the sum of all products whose multiplicand/multiplier/product identity can be written
-- as a 1 through 9 pandigital.
--
-- HINT: Some products can be obtained in more than one way so be sure to only include it once
-- in your sum.

-- Insights:
-- 1) len(result) == 4
-- 2) factors have only length 1 and 4 or 2 and 3

import Data.List

digits = [1..9]
chars  = ["1","2","3","4","5","6","7","8","9"]

isPandigital :: String -> Bool
isPandigital n = (length n ==9) && and [x `isInfixOf` n | x<-chars]

listOfMuls23 :: [String]
listOfMuls23 = [a ++ b ++ c ++ d ++ e ++ show(read(a++b) * read(c++d++e)) | a<-chars,
  let charsB = filter (/=a) chars , b<-charsB,
  let charsC = filter (/=b) charsB, c<-charsC,
  let charsD = filter (/=c) charsC, d<-charsD,
  let charsE = filter (/=d) charsD, e<-charsE]

listOfMuls14 :: [String]
listOfMuls14 = [a ++ b ++ c ++ d ++ e ++ show(read a * read(b++c++d++e)) | a<-chars,
  let charsB = filter (/=a) chars , b<-charsB,
  let charsC = filter (/=b) charsB, c<-charsC,
  let charsD = filter (/=c) charsC, d<-charsD,
  let charsE = filter (/=d) charsD, e<-charsE]

problem = sum $ nub $ map (read . drop 5) $ filter isPandigital (listOfMuls23 ++ listOfMuls14)
