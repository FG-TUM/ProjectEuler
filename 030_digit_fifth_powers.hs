-- Surprisingly there are only three numbers that can be written as the sum of fourth powers of their digits:
--
-- 1634 = 14 + 64 + 34 + 44
-- 8208 = 84 + 24 + 04 + 84
-- 9474 = 94 + 44 + 74 + 44
-- As 1 = 14 is not a sum it is not included.
--
-- The sum of these numbers is 1634 + 8208 + 9474 = 19316.
--
-- Find the sum of all the numbers that can be written as the sum of fifth powers of their digits.

sixDigits' = [(a,b,c,d,e,f,n) | a<-[0..9], b<-[0..9], c<-[0..9], d<-[0..9], e<-[0..9], f<-[0..9], n<-[a^5 + b^5 +c^5 + d^5 + e^5 + f^5], n >= 99999, n == f + 10*e + 100*d + 1000*c + 10000*b + 100000*a]
sixDigits  = [n | a<-[0..9], b<-[0..9], c<-[0..9], d<-[0..9], e<-[0..9], f<-[0..9], n<-[a^5 + b^5 +c^5 + d^5 + e^5 + f^5], n >= 99999, n == f + 10*e + 100*d + 1000*c + 10000*b + 100000*a]

fiveDigits'= [(a,b,c,d,e,n) | a<-[0..9], b<-[0..9], c<-[0..9], d<-[0..9], e<-[0..9], n<-[a^5 + b^5 +c^5 + d^5 + e^5], n >= 9999, n == 1*e + 10*d + 100*c + 1000*b + 10000*a]
fiveDigits = [n | a<-[0..9], b<-[0..9], c<-[0..9], d<-[0..9], e<-[0..9], n<-[a^5 + b^5 +c^5 + d^5 + e^5], n >= 9999, n == 1*e + 10*d + 100*c + 1000*b + 10000*a]

fourDigits'= [(a,b,c,d,n) | a<-[0..9], b<-[0..9], c<-[0..9], d<-[0..9], n<-[a^5 + b^5 +c^5 + d^5], n >= 999, n == 1*d + 10*c + 100*b + 1000*a]
fourDigits = [n | a<-[0..9], b<-[0..9], c<-[0..9], d<-[0..9], n<-[a^5 + b^5 +c^5 + d^5], n >= 999, n == 1*d + 10*c + 100*b + 1000*a]

threeDigits'= [(a,b,c,n) | a<-[0..9], b<-[0..9], c<-[0..9], n<-[a^5 + b^5 +c^5], n >= 99, n == c + 10*b + 100*a]
threeDigits = [n | a<-[0..9], b<-[0..9], c<-[0..9], n<-[a^5 + b^5 +c^5], n >= 99, n == c + 10*b + 100*a]

problem = sum $ sixDigits ++ fiveDigits ++ fourDigits ++ threeDigits
