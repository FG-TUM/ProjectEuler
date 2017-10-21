-- The 5-digit number, 16807=75, is also a fifth power. Similarly, the 9-digit number,
-- 134217728=89, is a ninth power.

-- How many n-digit positive integers exist which are also an nth power?

import MyLib_haskell

allNumbers = [n | base<-[1..9],
                  exp<-[1..100],
                  let n = base^exp,
                  exp  == numLength n
                  ]

main = print $ length allNumbers
