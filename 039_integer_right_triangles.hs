--If p is the perimeter of a right angle triangle with integral length sides, {a,b,c}, there are exactly three solutions for p = 120.
--{20,48,52}, {24,45,51}, {30,40,50}
--For which value of p ≤ 1000, is the number of solutions maximised?

import MyLib

main::IO()
main = print $ mostCommon [x+y+z | x <-[1..500], y <-[1..500], z <-[1..500], x<y, y<z, x^2 + y^2 == z^2]
