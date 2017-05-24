-- The decimal number, 585 = 10010010012 (binary), is palindromic in both bases.
-- Find the sum of all numbers, less than one million, which are palindromic in base 10 and base 2.
-- (Please note that the palindromic number, in either base, may not include leading zeros.)

import Data.List

digitListReverse :: (Integral a) => a -> [a]
digitListReverse x
  | x == 0    = []
  | otherwise = x `mod` 10 : digitListReverse (x `div` 10)

isPalindrome :: (Integral a) => a -> Bool
isPalindrome n = front == reverse back
  where
    nList = digitListReverse n
    len   = length nList
    (front, back) = if length nList `mod` 2 == 0
                      then splitAt (len `div` 2) nList
                      else (take (len `div` 2) nList, drop (len `div` 2 + 1) nList)

decToBin :: (Integral a) => a -> a
decToBin n = decToBinAux n 0 0

decToBinAux :: (Integral a) => a -> a -> a -> a
decToBinAux n pos res
  | n == 1 = res + 1 * 10^pos
  | otherwise = decToBinAux (n `div` 2) (pos + 1) (res + (n `mod` 2) * 10^pos)

main::IO()
main = print $ sum [x | x <- [1..1000000], (isPalindrome x) && (isPalindrome $ decToBin x)]
--main = mapM_ print [(x, decToBin x) | x <- [1..1000000], (isPalindrome x) && (isPalindrome $ decToBin x)]

