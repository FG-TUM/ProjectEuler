// A positive fraction whose numerator is less than its denominator is called a proper fraction.
// For any denominator, d, there will be d−1 proper fractions; for example, with d = 12:
// 1/12 , 2/12 , 3/12 , 4/12 , 5/12 , 6/12 , 7/12 , 8/12 , 9/12 , 10/12 , 11/12 .
//
// We shall call a fraction that cannot be cancelled down a resilient fraction.
// Furthermore we shall define the resilience of a denominator, R(d), to be the ratio of its
// proper fractions that are resilient; for example, R(12) = 4/11 .
// In fact, d = 12 is the smallest denominator having a resilience R(d) < 4/10 .
//
// Find the smallest denominator d, having a resilience R(d) < 15499/94744

/*
 * NOTES:
 * - resilience(n) = (number of coprimes to n) / n - 1
 * - use GCD to find coprimes
 * - primes can be disregarded since they have a very high resilience
 * - observe brute force and where local lows are found
 */

#include <iostream>
#include <omp.h>
#include <iomanip>
#include "MyLib_cpp.h"

using namespace std;

#define EFFICIENT

// const double targetResiliance = 4.0 / 10.0;
const double targetResiliance = 15499.0 / 94744.0;

inline double resilience(unsigned int d) {

    // 1/d and (d-1)/d can never be cancelled
    unsigned int nonreducableFractions = 2;

#pragma omp parallel for schedule(dynamic, 500) reduction(+:nonreducableFractions) if(d > 1000000)
    for (int i = 2; i < d-1; ++i) {
        if(areComprimes(d, i)) {
            ++nonreducableFractions;
        }
    }
    return nonreducableFractions / (double)(d-1);
}

int main(int argc, char **argv) {

    // only evaluate argument if given for debugging...
    if(argc == 2){
        unsigned int n = atoi(argv[1]);
        cout << "R(" << n << ") = " << resilience(n) << endl;
        return 0;
    }

    double minRes = 2;

    unsigned int step = 3,
                 numSteps = 0,
                 d = 3;

    while(minRes >= targetResiliance) {
        double thisRes = resilience(d);
        // DEBUG:
        // cout << "Step! R(" << setw(5) <<  d << ") = " << thisRes << endl;
        if(thisRes < targetResiliance){
            cout << "Found it! R(" << d << ") = " << thisRes << endl;
            return 0;
        }
        if (thisRes >= minRes) {
            cout << setw(2) << numSteps << " steps with width = " << step << endl;
            numSteps = 0;
            d -= step;
            step = d;
        } else {
            minRes = thisRes;
        }
        d += step;
        ++numSteps;
    }
    return -1;
}

