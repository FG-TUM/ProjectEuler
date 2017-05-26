--We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n exactly once.
--For example, 2143 is a 4-digit pandigital and is also prime.
--What is the largest n-digit pandigital prime that exists?

import MyLib_haskell
import Data.List

revListToInt :: [Integer] -> Integer
revListToInt xs
  | null xs = 0
  | otherwise = head xs + 10 * revListToInt (tail xs)

generateNumbers xs = map revListToInt $ permutations xs

main::IO()
main = print . maximum . filter (millerRabin [2, 3]) $ generateNumbers [1..7]
