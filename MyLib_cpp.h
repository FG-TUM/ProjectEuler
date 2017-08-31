#ifndef PROJECTEULER_MYLIB_H
#define PROJECTEULER_MYLIB_H

#include <stdint.h>

#include <cmath>
#include <iostream>
#include <utility>
#include <vector>

typedef int64_t num;

/**
 * Decides whether a and b are co prime (no common divisor)
 * @param a
 * @param b
 * @return true iff a and b are co prime
 */
bool areComprimes(num a, num b);

/**
 * Calculates the grates common divisor
 */
num gcd(num u, num v);

/**
 * Returns the list of digits of n. Duplicates are not eliminated and digits are in reverse order of occurrence.
 * @param n
 * @return vector containing all digits of n.
 */
std::vector<int> intToVec(int n);

/**
 * The Miller-Rabin primality test.
 * Returns true if ``n´´ is PROBABLY prime, false if it's composite.
 * @param n Number to test.
 * @param witness
 * @return true if n is probably a prime false if it is definitely no prime.
 */
bool millerRabin(num n, num witness);

/**
 * Miller-Rabin primality test with automatic witness selection
 *
 * @param n Number to test.
 * @return true if n is probably a prime false if it is definitely no prime.
 */
bool millerRabin(num n);

/**
 * The Miller-Rabin primality test.
 * Returns true if ``n´´ is PROBABLY prime, false if it's composite.
 *
 * witnesses for :
 * n < 4759123141   -> 2, 7, 61
 *
 * @param n Number to test.
 * @param witness vector of witnesses to test.
 * @return true if n is probably a prime false if it is definitely no prime.
 */
bool millerRabin(num n, std::vector<num> witness);

/**
 * Calculates the length of a given number
 * @param n
 * @return length of n
 */
unsigned int numLength(num n);

/**
 * Fast calculation of `a^x mod n´
 * @param a Base
 * @param x Exponent
 * @param n Modulo
 * @return `a^x mod n´
 */
static num powMod(num a, num x, num n);

/**
 * Rotates a given number digit wise to the right by one
 * @param n
 * @return rotated number
 */
num rotateNumRight(num n);

/**
 * Generate primes up to a given n
 * @param n
 * @return Vector containing all primes from 2 to n
 */
std::vector<unsigned int> sieveOfEratosthenes(unsigned int n);

#endif //PROJECTEULER_MYLIB_H
