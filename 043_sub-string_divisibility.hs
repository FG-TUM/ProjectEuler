--The number, 1406357289, is a 0 to 9 pandigital number because it is made up of each of
--the digits 0 to 9 in some order, but it also has a rather interesting sub-string
--divisibility property.

--Let d1 be the 1st digit, d2 be the 2nd digit, and so on.
--In this way, we note the following:

--d2d3d4=406  is divisible by  2
--d3d4d5=063  is divisible by  3
--d4d5d6=635  is divisible by  5
--d5d6d7=357  is divisible by  7
--d6d7d8=572  is divisible by 11
--d7d8d9=728  is divisible by 13
--d8d9d10=289 is divisible by 17

--Find the sum of all 0 to 9 pandigital numbers with this property.

--import Data.List
--import MyLib_haskell


--generateNumbers xs = map revListToInt $ permutations xs
  --where
    --revListToInt :: [Integer] -> Integer
    --revListToInt xs
      -- | null xs = 0
      -- | otherwise = head xs + 10 * revListToInt (tail xs)

brute = [read [d1,d2,d3,d4,d5,d6,d7,d8,d9,d10] :: Int |
             d1<-['1'..'9'],
             d2<-['0'..'9'],
             d3<-['0'..'9'],
             d4<-['0', '2'..'8'],
             d5<-['0'..'9'],
             d6<-['0','5'],
             d7<-['0'..'9'],
             d8<-['0'..'9'],
             d9<-['0'..'9'],
             d10<-['0'..'9'],
             d1/=d2, d1/=d3, d1/=d4, d1/=d5, d1/=d6, d1/=d7, d1/=d8, d1/=d9, d1/=d10,
                     d2/=d3, d2/=d4, d2/=d5, d2/=d6, d2/=d7, d2/=d8, d2/=d9, d2/=d10,
                             d3/=d4, d3/=d5, d3/=d6, d3/=d7, d3/=d8, d3/=d9, d3/=d10,
                                     d4/=d5, d4/=d6, d4/=d7, d4/=d8, d4/=d9, d4/=d10,
                                             d5/=d6, d5/=d7, d5/=d8, d5/=d9, d5/=d10,
                                                     d6/=d7, d6/=d8, d6/=d9, d6/=d10,
                                                             d7/=d8, d7/=d9, d7/=d10,
                                                                     d8/=d9, d8/=d10,
                                                                             d9/=d10,
             -- let n1 = read [d2,d3,d4]  ::Int, n1 `mod` 2 == 0,
             let n2 = read [d3,d4,d5]  ::Int, n2 `mod` 3 == 0,
             -- let n3 = read [d4,d5,d6]  ::Int, n3 `mod` 5 == 0,
             let n4 = read [d5,d6,d7]  ::Int, n4 `mod` 7 == 0,
             let n5 = read [d6,d7,d8]  ::Int, n5 `mod` 11 == 0,
             let n6 = read [d7,d8,d9]  ::Int, n6 `mod` 13 == 0,
             let n7 = read [d8,d9,d10] ::Int, n7 `mod` 17 == 0
          ]

main :: IO()
-- main = print $ length brute
main = print $ sum brute
