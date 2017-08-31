/*
 * The primes 3, 7, 109, and 673, are quite remarkable. By taking any two primes and concatenating them in any
 * order the result will always be prime. For example, taking 7 and 109, both 7109 and 1097 are prime.
 * The sum of these four primes, 792, represents the lowest sum for a set of four primes with this property.
 *
 * Find the lowest sum for a set of five primes for which any two primes concatenate to produce another prime.
 */

#include <vector>
#include <iostream>
#include "MyLib_cpp.h"

using namespace std;

vector<num> witnesses = {2, 7, 61};

bool checkPair(unsigned int p1, unsigned int p2) {

    return millerRabin(stol(to_string(p1) + to_string(p2)), witnesses)
           && millerRabin(stol(to_string(p2) + to_string(p1)), witnesses);
}

int main(int argc, char **argv) {

    int         jo = 0;
//    vector<num> w  = {2, 3, 5};
    vector<num> w  = {2, 31, 73};

    if (millerRabin(31, w))
        cout << "prime" << endl;
    else
        cout << "not prime" << endl;

#pragma omp parallel for schedule(dynamic, 500) reduction(+:jo)
    for (unsigned int i = 2; i < 9080191; ++i) {
        if (millerRabin(i, w))
            ++jo;
    }

    cout << jo << endl;
    return 42;


    // init with estimates about the problem
    unsigned int bestSum = 35000;
    unsigned int minSum  = 20000;

    vector<unsigned int> primes = sieveOfEratosthenes(20000);
    primes.erase(primes.begin());
    cout << "Using " << primes.size() << " primes from " << primes[0] << " to " << primes[primes.size() - 1] << endl;

    int lol = 42;

    for (unsigned int p1 = 0; p1 < primes.size(); ++p1) {
        if (primes[p1] * 5 >= bestSum)
            break;
        for (unsigned int p2 = p1 + 1; p2 < primes.size(); ++p2) {
            if (primes[p1] + primes[p2] * 4 >= bestSum)
                break;
            if (!checkPair(primes[p1], primes[p2]))
                continue;
            for (unsigned int p3 = p2 + 1; p3 < primes.size(); ++p3) {
                if (primes[p1] + primes[p2] + primes[p3] * 3 >= bestSum)
                    break;
                if (!checkPair(primes[p1], primes[p3])
                    || !checkPair(primes[p2], primes[p3]))
                    continue;
                for (unsigned int p4 = p3 + 1; p4 < primes.size(); ++p4) {
                    if (primes[p1] + primes[p2] + primes[p3] + primes[p4] * 2 >= bestSum)
                        break;
                    if (!checkPair(primes[p1], primes[p4])
                        || !checkPair(primes[p2], primes[p4])
                        || !checkPair(primes[p3], primes[p4]))
                        continue;
                    for (unsigned int p5 = p4 + 1; p5 < primes.size(); ++p5) {
                        unsigned int primeSum = primes[p1] + primes[p2] + primes[p3] + primes[p4] + primes[p5];
                        if (primeSum >= bestSum || primeSum <= minSum)
                            break;
                        if (!checkPair(primes[p1], primes[p5])
                            || !checkPair(primes[p2], primes[p5])
                            || !checkPair(primes[p3], primes[p5])
                            || !checkPair(primes[p4], primes[p5]))
                            continue;

                        bestSum = primeSum;
                        cout << "New best: " << bestSum << " | "
                             << primes[p1] << ", "
                             << primes[p2] << ", "
                             << primes[p3] << ", "
                             << primes[p4] << ", "
                             << primes[p5] << endl;
                    }
                }
            }
        }
    }
}