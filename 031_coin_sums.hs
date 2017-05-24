-- In England the currency is made up of pound, £, and pence, p, and
-- there are eight coins in general circulation:
--
-- 1p, 2p, 5p, 10p, 20p, 50p, £1 (100p) and £2 (200p).
-- It is possible to make £2 in the following way:
--
-- 1×£1 + 1×50p + 2×20p + 1×5p + 1×2p + 3×1p
-- How many different ways can £2 be made using any number of coins?


-- problem n = length [(p1, p2, p5, p10, p20, p50, pound1) | p1 <-[0..200], p2 <-[0..100], p5<-[0..40], p10<-[0..20], p20<-[0..10], p50<-[0..4], pound1<-[0..2], p1+p2*2+p5*5+p10*10+p20*20+p50*50+pound1*100==n]

xCng :: Int -> Int
xCng n = xCngAux 0 n [1,2,5,10,20,50,100,200]

xCngAux :: Int -> Int -> [Int] -> Int
xCngAux acc total coins
  | acc > total  = 0
  | acc == total = 1
  | coins == [] = 0
  | otherwise   = withHead + withoutHead
  where withHead    = xCngAux (acc + head coins) total coins
        withoutHead = xCngAux acc total (tail coins)

main :: IO()
main = print $ xCng 200
