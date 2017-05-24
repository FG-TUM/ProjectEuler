#include <iostream>
#include <cmath>
#include <array>
#include <vector>
#include <algorithm>

using namespace std;

typedef long num;

static const array<int, 4> possibleDigits = {1, 3, 7, 9};
int                        numbersFound   = 2;
vector<num>                founds;

/**
 * Fast calculation of `a^x mod n´
 */
static num pow_mod(num a, num x, num n) {
    num r = 1;

    while (x) {
        if ((x & 1) == 1)
            r = a * r % n;

        x >>= 1;
        a     = a * a % n;
    }

    return r;
}

/**
 * The Miller-Rabin probabilistic primality test.
 * Returns true if ``n´´ is PROBABLY prime, false if it's composite.
 * The parameter ``k´´ is the accuracy.
 */
bool millerRabin(num n, num witness) {
    if (n == 2 || n == 3)
        return true;
    if (n <= 1 || !(n & 1))
        return false;

    // Write n-1 as m*2^k by factoring powers of 2 from n-1
    int k = 0;

    for (num i = n - 1; !(i & 1); i >>= 1) {
        ++k;
    }

    num m = (n - 1) / (1 << k);

    num x = pow_mod(witness, m, n);

    if (x == 1 || x == n - 1)
        return true;

    for (int r = 1; r <= k - 1; ++r) {
        x = pow_mod(x, 2, n);
        if (x == 1)
            return false;
        if (x == n - 1)
            return true;
    }

    return false;
}

/**
 * Rotates a given number digit wise to the right by one
 * @param n
 * @return rotated number
 */
num rotateNumRight(num n) {

    int length = (int) ceil(log10(n));

    num lastDigit = n % 10;
    num res       = (lastDigit * (num) pow(10, length - 1)) + n / 10;

    return res;
}

inline num appendDigit(num n, int digit) {
    return n * 10 + digit;
}

bool checkRotationsPrime(num n, int length) {
    for (int i = 0; i < length; ++i) {
        if (not millerRabin(n, 2) and not millerRabin(n, 3))
            return false;
        n = rotateNumRight(n);
    }
//    founds.push_back(n);
    return true;
}

void traversePowerSet(num currentNum, int maxLength, int length) {
    if (length > maxLength)
        return;
    for (int i = 0; i < possibleDigits.size(); ++i) {
        currentNum = appendDigit(currentNum, possibleDigits[i]);
//        cout << currentNum << endl;
        if (checkRotationsPrime(currentNum, length))
            ++numbersFound;
        traversePowerSet(currentNum, maxLength, length + 1);
        currentNum /= 10;
    }
}

int main(void) {

    founds.push_back(2);
    founds.push_back(5);

    traversePowerSet(0, 6, 1);

    cout << numbersFound << endl << endl;

//    sort(founds.begin(), founds.end());
//    for (num n : founds) {
//        cout << n << endl;
//    }
}
