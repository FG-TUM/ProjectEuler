-- The prime 41, can be written as the sum of six consecutive primes:

-- 41 = 2 + 3 + 5 + 7 + 11 + 13
-- This is the longest sum of consecutive primes that adds to a prime below one-hundred.

-- The longest sum of consecutive primes below one-thousand that adds to a prime, contains 21 terms, and is equal to 953.

-- Which prime, below one-million, can be written as the sum of the most consecutive primes?

import MyLib_haskell
import Data.List

main::IO()
main = print
        $ last
        $ filter (millerRabin [2,3])
        $ takeWhile (<1000000)
        $ drop 2                  -- drop 0 and 2 because it crashes the millerRabin test
        $ scanl (+) 0 (drop 3     -- empirically optimized lol
                        $ sort
                        $ sieveOfEratosthenes 100000)
