-- An irrational decimal fraction is created by concatenating the positive integers:
-- 0.123456789101112131415161718192021...
-- It can be seen that the 12th digit of the fractional part is 1.
-- If dn represents the nth digit of the fractional part, find the value of the following expression.
-- d1 × d10 × d100 × d1000 × d10000 × d100000 × d1000000

import MyLib_haskell

intToList ::  Int -> [Int]
intToList n = reverse
              . map snd
              . drop 1
              . take (numLength n + 1)
              . iterate (\(x, y) -> (x `div` 10, x `mod` 10))
              $ (n,0)

irratDecFrac :: Int -> [Int]
irratDecFrac n = concat [ intToList x | x <- [1..n]]

result :: [Int] -> Int -> Int -> Int
result list index res
  | index < 1 = res
  | otherwise = result list (index `div` 10) (res * (list !! index))

main::IO()
main = print $ result (0 : irratDecFrac 200000) 1000000 1

