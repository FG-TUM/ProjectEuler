-- It was proposed by Christian Goldbach that every odd composite number can be written
-- as the sum of a prime and twice a square.

--  9 =  7 + 2×1^2
-- 15 =  7 + 2×2^2
-- 21 =  3 + 2×3^2
-- 25 =  7 + 2×3^2
-- 27 = 19 + 2×2^2
-- 33 = 31 + 2×1^2

-- It turns out that the conjecture was false.

-- What is the smallest odd composite that cannot be written as the sum of a prime and
-- twice a square?

import Data.List
import Control.Arrow
import MyLib_haskell

primes = sort $ sieveOfEratosthenes 10000

fits n = 0 < length [x | p <- takeWhile (<(n-1)) primes,
                         a <- [1..(sqrt' (n `div` 2))],
                         let x = p + 2*a*a,
                         x == n
                    ]

maxIndex max = length $ takeWhile (==True) $ map fits (theList max)

theList max = [9,11..max] \\ sieveOfEratosthenes max

main = print $ fst $ head $ filter (\x -> snd x ==False) $ map (id &&& fits) (theList n)
  where
    n = 100000
