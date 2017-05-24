-- The fraction 49/98 is a curious fraction, as an inexperienced mathematician in attempting to
-- simplify it may incorrectly believe that 49/98 = 4/8, which is correct, is obtained by
-- cancelling the 9s.
--
-- We shall consider fractions like, 30/50 = 3/5, to be trivial examples.
--
-- There are exactly four non-trivial examples of this type of fraction, less than one in value,
-- and containing two digits in the numerator and denominator.
--
-- If the product of these four fractions is given in its lowest common terms, find the value of
-- the denominator.

chars = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

fractionsA = [(a++c,b++c) | a <-chars, b<-chars, c<-chars,
  let frac = (read(a++c) / read(b++c)), frac < 1, frac == (read a / read b)]
fractionsB = [(c++a,c++b) | a <-chars, b<-chars, c<-chars,
  let frac = (read(c++a) / read(c++b)), frac < 1, frac == (read a / read b)]
fractionsC = [(a++c,c++b) | a <-chars, b<-chars, c<-chars,
  let frac = (read(a++c) / read(c++b)), frac < 1, frac == (read a / read b)]
fractionsD = [(c++a,b++c) | a <-chars, b<-chars, c<-chars,
  let frac = (read(c++a) / read(b++c)), frac < 1, frac == (read a / read b)]
