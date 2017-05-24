#ifndef PROJECTEULER_MYLIB_H
#define PROJECTEULER_MYLIB_H

#include <cmath>
#include <stdint.h>

typedef int64_t num;

/**
 * Fast calculation of `a^x mod n´
 * @param a Base
 * @param x Exponent
 * @param n Modulo
 * @return `a^x mod n´
 */
static num pow_mod(num a, num x, num n);

/**
 * The Miller-Rabin probabilistic primality test.
 * Returns true if ``n´´ is PROBABLY prime, false if it's composite.
 * The parameter ``k´´ is the accuracy.
 */
bool millerRabin(num n, num witness);

/**
 * Rotates a given number digit wise to the right by one
 * @param n
 * @return rotated number
 */
num rotateNumRight(num n);

#endif //PROJECTEULER_MYLIB_H
