module MyLib
( aksTest
, deleteMultiples
, even'
, fastExp
, fibonacci
, intLog2
, nonprimes
, perfectPowerTest
, primes
, sieveOfEratosthenes
, sqrt'
) where

import Data.Bits

-- deterministic primality test
aksTest :: Integer -> Bool
aksTest n
  | n < 2     = False  -- need to be excluded because of findR
  | otherwise = and [mod s n == 0 | s <- tail $ halfExpand n]

-- returns the first half (if length is odd including mid) of the coefficients 
-- of the polynomial (x+1)^n  as second is identical
halfExpand :: Integer -> [Integer]
halfExpand n = scanl (\z i -> div (z * (n-i+1)) i) 1 [1..(div n 2)]

-- deletes all multiples of n from a given list
deleteMultiples ::  (Integral a) => a -> [a] -> [a]
deleteMultiples n list = [x | x <- list, (mod x n) /= 0]

-- optimized even for Int
even' :: Int -> Bool
even' n
  | n .&. 1 == 0 = True
  | otherwise = False

-- fast version for y = a^n
fastExp :: Integer -> Integer -> Integer
fastExp 0 _ = 0
fastExp a 1 = a
fastExp a n = fastExpAux a n 1

fastExpAux :: Integer -> Integer -> Integer -> Integer
fastExpAux b n y
  | n == 0        = y
  | n .&. 1 == 1  = fastExpAux (b*b) (shiftR n 1) (y*b)
  | otherwise     = fastExpAux (b*b) (shiftR n 1) y

-- calculates the n-th fibonacci number
fibonacci :: (Integral a) => a -> a
fibonacci 1 = 1
fibonacci 2 = 1
fibonacci n = fibonacci (n-1) + fibonacci (n-2)

intLog2 :: Integer -> Integer
intLog2 n = floor $ logBase 2 (fromInteger n)

-- if n is a perfect power the fuction returns m^e = n else (-1,-1)
perfectPowerTest :: Integer -> (Integer,Integer)
perfectPowerTest n = perfectPowerTestAux n 2 (floor $ logBase 2 (fromInteger n)) 2 n

perfectPowerTestAux :: Integer -> Integer -> Integer -> Integer -> Integer -> (Integer,Integer)
perfectPowerTestAux n e maxE m1 m2
  | e > maxE    = (-1,-1)
  | m1 > m2     = perfectPowerTestAux n (e+1) maxE 2 n
  | mToE == n   = (m,e)
  | mToE >  n   = perfectPowerTestAux n e maxE m1 (m-1)
  | otherwise   = perfectPowerTestAux n e maxE (m+1) m2
  where m = div (m1 + m2) 2 -- div truncates towards neg inf
        mToE = fastExp m e

-- returns all prime numbers between 2 and n
sieveOfEratosthenes :: Integer -> [Integer]
sieveOfEratosthenes n = takeWhile (\a -> a <= n) primes

----- helper functions for sieveoferatosthenes --

-- expects two sorted infinite lists 
-- returns a sorted merged infinite list
merge :: (Ord a) => [a] -> [a] -> [a]
merge xs@(x:xt) ys@(y:yt) =
  case compare x y of
    LT -> x : (merge xt ys)
    EQ -> x : (merge xt yt)
    GT -> y : (merge xs yt)

-- expects two sorted infinite lists
-- returns the first list without all elements of the second list
diff :: (Ord a) => [a] -> [a] -> [a]
diff xs@(x:xt) ys@(y:yt) =
  case compare x y of
    LT -> x : (diff xt ys)
    EQ -> diff xt yt
    GT -> diff xs yt

-- calculates an infinite list of all odd nonprimes > 9
nonprimes :: [Integer]
nonprimes = foldr1 f $ map g $ tail primes
  where
    f (x:xt) ys = x : (merge xt ys)
    g p         = [ n * p | n <- [p, p + 2 ..]]

-- calculates an infinite list of primes
primes :: [Integer]
primes    = [2, 3, 5] ++ (diff [7, 9 ..] nonprimes)

-- to take the first n primes use:
-- take n primes
-- to take all primes < n use:
-- takeWhile (\a -> a<n) primes

----- end of helper functions -------------------

-- square root for integrals
sqrt' :: (Integral a) => a -> a
sqrt' n = floor (sqrt ( fromIntegral n))
