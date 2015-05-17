-- The sequence of triangle numbers is generated by adding the natural numbers. 
-- So the 7th triangle number would be 1 + 2 + 3 + 4 + 5 + 6 + 7 = 28. 
-- The first ten terms would be:
-- 
-- 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...
-- 
-- Let us list the factors of the first seven triangle numbers:
-- 
--  1: 1
--  3: 1,3
--  6: 1,2,3,6
-- 10: 1,2,5,10
-- 15: 1,3,5,15
-- 21: 1,3,7,21
-- 28: 1,2,4,7,14,28
-- We can see that 28 is the first triangle number to have over five divisors.
-- 
-- What is the value of the first triangle number to have over five hundred divisors?

-- numberOfDivisors => n = Product(x_n + 1) 
-- where x_n are numbers of instances of primefactors of n

import Data.Bits


-- returns the triangle number with index i
triangleNumber' :: (Integral a) => a -> a
triangleNumber' i = sum [1..i]

-- optimized version using gaussian summation formula
triangleNumber :: (Integral a) => a -> a
triangleNumber i = div ((i+1) * i) 2
  
-- returns a list of all triangle Numbers from the given index intervall
triangleNumberList :: (Integral a) => a -> a -> [a]
triangleNumberList i j = map triangleNumber [i..j]

numberOfDivisors :: (Integral a) => a -> Int
numberOfDivisors n = length [x | x <- [1..n], mod n x == 0]

listDivisors :: (Integral a) => a -> [a]
listDivisors n = [x | x <- [1..n], mod n x == 0]

-- returns the first triangleNumber that has the given amount of divisors n
highDivTriangularNum :: (Integral a) => Int -> a
highDivTriangularNum n = highDivTriangularNumAux n 1

highDivTriangularNumAux :: (Integral a) => Int -> a -> a
highDivTriangularNumAux n i
  | numberOfDivisors t >= n = t
  | otherwise = highDivTriangularNumAux n (i+1)
  where t = triangleNumber i

  
-- ATTEMPT 2:

-- returns the first triangleNumber that has at least n divisors
highDivTriangularNum' :: (Integral a) => a -> a
highDivTriangularNum' n = highDivTriangularNum'Aux n 1

highDivTriangularNum'Aux :: (Integral a) => a -> a -> a
highDivTriangularNum'Aux n i
  | (numberOfDivisors' t) < n = highDivTriangularNum'Aux n (i+1)
  | otherwise = t
  where t = triangleNumber i

numberOfDivisors' :: (Integral a) => a -> a
numberOfDivisors' n = foldr (\x y -> (snd x +1) *  y) 1 (squeeze $ primefactors n)

-- returns a list of all products of a given list
listProducts :: (Integral a) => [a] -> [a]
listProducts l = listProductsAux l []

listProductsAux :: (Integral a) => [a] -> [a] -> [a]
listProductsAux l retL
  | l == [] = retL
  | otherwise = listProductsAux tailL (map (\x -> headL * x) tailL) ++ retL
  where tailL = tail l
        headL = head l
 
-- deletes all multiple instances in a list
delDuplicates :: (Integral a) => [a] -> [a]
delDuplicates l = delDuplicatesAux l []

delDuplicatesAux :: (Integral a) => [a] -> [a] -> [a]
delDuplicatesAux l retL
  | l == [] = retL
  | elem headL retL = delDuplicatesAux tailL retL
  | otherwise = delDuplicatesAux tailL (headL : retL)
  where tailL = tail l
        headL = head l
        
-- returns a touple list with (primefactor, number of occurences)
sortedPrimefactors :: (Integral a) => a -> [(a,a)]
sortedPrimefactors n = squeeze $ primefactors n

-- lists all prime factors of n
primefactors :: (Integral a) => a -> [a]
primefactors n = primefactorsAux n 2 []

primefactorsAux :: (Integral a) => a -> a -> [a] -> [a]
primefactorsAux n divisor factors
  | n == 1 = factors
  | (mod n divisor) == 0 = primefactorsAux (div n divisor) (divisor) (divisor:factors)
  | otherwise = primefactorsAux n (divisor+1) factors
  
-- squeezes consecutive instances of an integral to a touple containing 
-- the integral and number of occurences
squeeze :: (Integral a) => [a] -> [(a,a)]
squeeze l = squeezeAux l []

squeezeAux :: (Integral a) => [a] -> [(a,a)] -> [(a,a)]
squeezeAux [] retL = retL
squeezeAux (h:l) retL
  | elem' h retL = squeezeAux l (incToupleList h retL)
  | otherwise = squeezeAux l ((h,1) : retL)

-- returns a list with the number of occurences of elements of a given list
-- works only on sorted lists
squeeze2 :: (Integral a) => [a] -> [a]
squeeze2 l = squeeze2Aux l 0 []

squeeze2Aux :: (Integral a) => [a] -> a -> [a] -> [a]
squeeze2Aux l x retL
  | l == [] = retL
  | head l == x =  squeeze2Aux (tail l) x ((head retL +1) : (tail retL))
  | otherwise = squeeze2Aux (tail l) (head l) (1 : retL)
  
-- increments the second touple element of a given first touple element
incToupleList :: (Integral a) => a -> [(a,a)] -> [(a,a)]
incToupleList n l = map (\x -> if fst x == n  then (n,succ $ snd x) else ( fst x, snd x)) l

-- compares two touples and returns the one with the bigger second entry
maxTouple :: (Ord b) => (a, b) -> (a, b) -> (a, b)
maxTouple t1 t2
  | snd t1 > snd t2 = t1
  | otherwise = t2

-- checks weather n is in any first position of any touple of a list
elem' :: (Integral a) => a -> [(a,a)] -> Bool
elem' n l = any (\x -> fst x == n) l

elem'Aux :: (Integral a) => a -> [(a,a)] -> Bool
elem'Aux n l
  | l == [] = False
  | n == (fst (head l)) = True
  | otherwise = elem' n (tail l)

-- returns the factorial of n
factorial :: (Integral a) => a -> a
factorial n = product [1..n]

-- returns the binomial coefficient n over k
binomial :: (Integral a) => a -> a -> a
binomial n k = div (factorial n) (factorial k * factorial (n - k))

main :: IO()
main = putStrLn $ show $ highDivTriangularNum' 500
  
-- unused:

-- returns the number of numbers that are relatively prime to n
eulersTotient :: (Integral a) => a -> Int
eulersTotient n = length [ x | x <- [1..n], gcd x n == 1]
