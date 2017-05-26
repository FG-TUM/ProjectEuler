--Euler discovered the remarkable quadratic formula:
--
--n² + n + 41
--
--It turns out that the formula will produce 40 primes for the consecutive values n = 0 to 39. However, when n = 40, 402 + 40 + 41 = 40(40 + 1) + 41 is divisible by 41, and certainly when n = 41, 41² + 41 + 41 is clearly divisible by 41.
--
--The incredible formula  n² − 79n + 1601 was discovered, which produces 80 primes for the consecutive values n = 0 to 79. The product of the coefficients, −79 and 1601, is −126479.
--
--Considering quadratics of the form:
--
--n² + an + b, where |a| < 1000 and |b| < 1000
--
--where |n| is the modulus/absolute value of n
--e.g. |11| = 11 and |−4| = 4
--Find the product of the coefficients, a and b, for the quadratic expression that produces the maximum number of primes for consecutive values of n, starting with n = 0.

import MyLib_haskell
import Data.List

toupleMax (a1, a2, a3) (b1, b2, b3)
  | a3 >= b3 = (a1, a2, a3)
  | otherwise = (b1, b2, b3)

listForB = sort $ sieveOfEratosthenes 1000
listForA = [-999, -997..1000]

primeList a b = takeWhile aksTest [n*n + a * n + b | n <-[0..]]

problem = foldl toupleMax (0,0,0) [(a, b, length $ primeList a b) | a <- listForA, b <- listForB]

main :: IO()
main = print $ problem
