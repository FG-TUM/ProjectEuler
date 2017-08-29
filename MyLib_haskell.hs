module MyLib_haskell 
( aksTest
, choose'
, deleteMultiples
, even'
, fac
, fastExp
, fibonacci
, millerRabin
, mostCommon
, numLength
, intLog2
, isHexagonNum
, isInt
, isPalindrome
, isPentagonNum
, isTriangleNum
, perfectPowerTest
, reverseInt
, rotate'
, sieveOfEratosthenes
, sqrt'
) where

import Data.Bits
import Control.Arrow
import Data.List
import Data.Function

-- quick deterministic test for primiality
aksTest :: Integer -> Bool
aksTest p
  | p < 2 = False
  | perfectPowerTest p /= (-1,-1) = False
  | otherwise = and [mod n p == 0 | n <- init . tail $ expand]
  where expand = scanl (\z i -> z * (p-i+1) `div` i) 1 [1..p]

-- binomial coefficient
choose' :: (Integral a) => a -> a -> a
choose' n k = foldl (\z i -> (z * (n-i+1)) `div` i) 1 [1..k]

-- deletes all multiples of n from a given list
deleteMultiples ::  (Integral a) => a -> [a] -> [a]
deleteMultiples n list = [x | x <- list, mod x n /= 0]

-- optimized even for Int
even' :: Int -> Bool
even' n
  | n .&. 1 == 0 = True
  | otherwise = False

fac :: (Integral a) => a -> a
fac 0 = 1
fac 1 = 1
fac n = product [2..n]

-- fast version for y = a^n
fastExp :: Integer -> Integer -> Integer
fastExp 0 _ = 0
fastExp a 0 = 1
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

isHexagonNum :: Int -> Bool
isHexagonNum n = isInt $ (sqrt (1 + 8 * fromIntegral n) + 1) / 4

isInt :: RealFrac a => a -> Bool
isInt x = x == fromInteger (round x)

isPalindrome :: Integer -> Bool
isPalindrome n = n == reverseInt n

isPentagonNum :: Int -> Bool
isPentagonNum n = isInt $ (sqrt (1 + 24 * fromIntegral n) + 1) / 6

isTriangleNum :: Int -> Bool
isTriangleNum n = isInt $ sqrt (0.25 + 2 * fromIntegral n) - 0.5

-- millerRabin test for primiality for a given list of witnesses
millerRabin :: [Integer] -> Integer ->Bool
millerRabin witnesses n = all (millerRabinPrimality n) witnesses
-- n is the number to test; a is the (presumably randomly chosen) witness
millerRabinPrimality :: Integer -> Integer -> Bool
millerRabinPrimality n a
    | a <= 1 || a >= n-1 = 
        error $ "millerRabinPrimality: a out of range (" 
              ++ show a ++ " for "++ show n ++ ")" 
    | n < 2 = False
    | even n = False
    | b0 == 1 || b0 == n' = True
    | otherwise = iter (tail b)
    where
        n' = n-1
        (k,m) = find2km n'
        -- (eq. to) find2km (2^k * n) = (k,n)
        find2km :: Integral a => a -> (a,a)
        find2km = f 0
            where
                f k m
                    | r == 1 = (k,m)
                    | otherwise = f (k+1) q
                    where (q,r) = quotRem m 2
        b0 = powMod n a m
        b = take (fromIntegral k) $ iterate (squareMod n) b0
        iter [] = False
        iter (x:xs)
            | x == 1 = False
            | x == n' = True
            | otherwise = iter xs
        squareMod :: Integral a => a -> a -> a
        squareMod a b = (b * b) `rem` a
        -- (eq. to) powMod m n k = n^k `mod` m
        powMod :: Integral a => a -> a -> a -> a
        powMod m = pow' (mulMod m) (squareMod m)
          where
            mulMod :: Integral a => a -> a -> a -> a
            mulMod a b c = (b * c) `mod` a
            -- (eq. to) pow' (*) (^2) n k = n^k
            pow' :: (Num a, Integral b) => (a->a->a) -> (a->a) -> a -> b -> a
            pow' _ _ _ 0 = 1
            pow' mul sq x' n' = f x' n' 1
                where 
                    f x n y
                        | n == 1 = x `mul` y
                        | r == 0 = f x2 q y
                        | otherwise = f x2 q (x `mul` y)
                        where
                            (q,r) = quotRem n 2
                            x2 = sq x

-- returns the most common element in a list
-- (head &&& length) == (\ a -> (head a, length a))
mostCommon :: Ord c => [c] -> c
mostCommon list = fst . maximumBy (compare `on` snd) $ elemCount
      where elemCount = map (head &&& length) . group . sort $ list

--returns the length of an integer
numLength :: (Show a) => a -> Int
numLength n = length $ show n

-- if n is a perfect power the fuction returns m^e = n else (-1,-1)
perfectPowerTest :: Integer -> (Integer,Integer)
perfectPowerTest n = perfectPowerTestAux n 2 (floor $ logBase 2 (fromInteger n)) 2 n

perfectPowerTestAux :: Integer -> Integer -> Integer -> Integer -> Integer -> (Integer,Integer)
perfectPowerTestAux n e maxE m1 m2
  | e > maxE    = (-1,-1)   -- not a perfect power
  | m1 > m2     = perfectPowerTestAux n (e+1) maxE 2 n
  | mToE == n   = (m,e)
  | mToE >  n   = perfectPowerTestAux n e maxE m1 (m-1)
  | otherwise   = perfectPowerTestAux n e maxE (m+1) m2
  where m = div (m1 + m2) 2 -- div truncates towards neg inf
        mToE = fastExp m e

reverseInt :: Integer -> Integer
reverseInt = aux 0
  where aux rev 0 = rev
        aux rev n = let(q,r) = n `quotRem` 10 in aux (rev * 10 + r) q

-- rotate a list to the left
rotate' :: Int -> [a] -> [a]
rotate' n list
  | n == 0    = list
  | null list = []
  | n == 1    = tail list ++ [head list]
  | otherwise = drop n' list ++ take n' list
  where n' = n `mod` length list

-- returns all prime numbers between 2 and n
sieveOfEratosthenes :: (Integral a) => a -> [a]
sieveOfEratosthenes n = sieveOfEratosthenesAux (sqrt' n) [2..n] []

sieveOfEratosthenesAux :: (Integral a) => a -> [a] -> [a] -> [a]
sieveOfEratosthenesAux endN list primes
  | head list > endN = primes ++ list
  | otherwise = sieveOfEratosthenesAux endN (deleteMultiples (head list) list) (head list : primes)

-- square root for integrals
sqrt' :: (Integral a) => a -> a
sqrt' n = floor (sqrt ( fromIntegral n))

