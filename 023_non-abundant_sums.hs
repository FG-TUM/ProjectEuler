-- A perfect number is a number for which the sum of its proper divisors is exactly equal to 
-- the number. For example, the sum of the proper divisors of 28 would be 
-- 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect number.
-- 
-- A number n is called deficient if the sum of its proper divisors is less than n and it is 
-- called abundant if this sum exceeds n.
-- 
-- As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest number that 
-- can be written as the sum of two abundant numbers is 24. By mathematical analysis, it can 
-- be shown that all integers greater than 28123 (wiki, oeis: 20161) can be written as the sum of two abundant 
-- numbers. However, this upper limit cannot be reduced any further by analysis even though 
-- it is known that the greatest number that cannot be expressed as the sum of two abundant 
-- numbers is less than this limit.
-- 
-- Find the sum of all the positive integers which cannot be written as the sum of two 
-- abundant numbers

-- Find: sum [x | x <- [1..28123] isSumOfTwoAbundandNumbers x == False]
-- additional info: smallest abundant number prime to 2 and 3 is 5391411025
-- if n is abundant n*k is also abundant
-- the greatest number thats a sum of 2 abundant numbers is 20161

import MyLib
import Data.List
import Data.Set

sumOfDivisors :: Int -> Int
sumOfDivisors n = product [(p^(a+1) -1) `div` (p-1) | p<-sieveOfEratosthenes n, n `mod` p == 0,  a<-[maximum $ takeWhile (\x -> n `mod` p^x == 0) [1..]]] - n

sumOfDivisors' :: Int -> Int
sumOfDivisors' n = sum $ listDivisors n

listDivisors:: Int -> [Int]
listDivisors n = [x | x<-[1..(n `div` 2)], n `mod` x == 0]

listAbundandNumbers :: Int -> [Int]
listAbundandNumbers n = [x | x<-[12..n], sumOfDivisors' x > x]

listOfSums :: Int -> [Int]
listOfSums n = toList $ fromList $ listOfSumsAux (listAbundandNumbers n) []

listOfSumsAux :: [Int] -> [Int] -> [Int]
listOfSumsAux list res
  | list == [] = res
  | otherwise  = listOfSumsAux (tail list) ([head list + x | x <- list] ++ res)

main :: IO()
{-main = print $ length $ listOfSums 20161-}
main = print $ sum [x | x<-[1..20161], (x `elem` l) == False]
  where l = listOfSums 20161
