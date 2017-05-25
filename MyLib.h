#ifndef PROJECTEULER_MYLIB_H
#define PROJECTEULER_MYLIB_H

#include <cmath>
#include <stdint.h>
#include <vector>

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
 * The Miller-Rabin primality test.
 * Returns true if ``n´´ is PROBABLY prime, false if it's composite.
 * @param n Number to test.
 * @param witness
 * @return true if n is probably a prime false if it is definitely no prime.
 */
bool millerRabin(num n, num witness);

/**
 * The Miller-Rabin primality test.
 * Returns true if ``n´´ is PROBABLY prime, false if it's composite.
 * @param n Number to test.
 * @param witness vector of witnesses to test.
 * @return true if n is probably a prime false if it is definitely no prime.
 */
bool millerRabin(num n, std::vector<num> witness);


/**
 * Rotates a given number digit wise to the right by one
 * @param n
 * @return rotated number
 */
num rotateNumRight(num n);

/**
 * Calculates the length of a given number
 * @param n
 * @return length of n
 */
unsigned int numLength(num n);

#endif //PROJECTEULER_MYLIB_H
