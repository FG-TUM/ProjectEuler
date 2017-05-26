-- 145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.
--
-- Find the sum of all numbers which are equal to the sum of the factorial of their digits.
--
-- Note: as 1! = 1 and 2! = 2 are not sums they are not included.
import MyLib_haskell

chars = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
digits= [0..9]

digits3 = [100*c + 10*b + a |
  c<-tail digits, b<-digits, a<-digits,
  fac c + fac b + fac a == 100*c + 10*b + a ]
digits5 = [10000*e + 1000*d + 100*c + 10*b + a |
  e<-tail digits, d<-digits, c<-digits, b<-digits, a<-digits,
  fac e + fac d + fac c + fac b + fac a == 10000*e + 1000*d +100*c + 10*b + a]

problem = sum (digits3 ++ digits5)
