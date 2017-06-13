/*
 * The first two consecutive numbers to have two distinct prime factors are:
 *
 * 14 = 2 × 7
 * 15 = 3 × 5
 *
 * The first three consecutive numbers to have three distinct prime factors are:
 *
 * 644 = 2² × 7 × 23
 * 645 = 3 × 5 × 43
 * 646 = 2 × 17 × 19.
 *
 * Find the first four consecutive integers to have four distinct prime factors each. What is the first of these numbers?
 */

#include <stdio.h>
#include <iostream>

#define N 1000000

static int factorCount[N];

int main(void) {
    int i, j;

    for (i = 0; i < N; i++) {
        factorCount[i] = 0;
    }

    for (i = 2; i < N; i++) {
        if (factorCount[i] == 0) { // Number is prime
            for (j = i; j < N; j += i) {
                factorCount[j]++;
            }
        }
    }

    int desiredNumFactors = 4;
    int hitsInARow        = 0;
    int firstHit          = -1;

    for (int i = 0; i < N; ++i) {
        if (factorCount[i] >= desiredNumFactors) {
            if (hitsInARow == 0)
                firstHit = i;
            ++hitsInARow;
            if(hitsInARow == desiredNumFactors){
                for (int j = 0; j < desiredNumFactors; ++j) {
                    std::cout << firstHit + j << std::endl;
                }
                return 0;
            }
        } else {
            hitsInARow = 0;
        }
    }
    return 1;
}