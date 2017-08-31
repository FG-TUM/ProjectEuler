#include "MyLib_cpp.h"

bool areComprimes(num a, num b) {
    if (!((a | b) & 1))
        return false; // Both are even numbers, divisible by at least 2.
    return 1 == gcd(a, b);
}

num gcd(num u, num v) {
    auto shift = __builtin_ctz(u | v);
    u >>= __builtin_ctz(u);
    do {
        v >>= __builtin_ctz(v);
        if (u > v)
            std::swap(u, v);
    } while ((v -= u));
    return u << shift;
}

std::vector<int> intToVec(int n) {
    std::vector<int> retVec;
    auto             lenN = numLength(n);
    retVec.reserve(lenN);

    for (int i = 0; i < lenN; ++i) {
        retVec.push_back(n % 10);
        n /= 10;
    }

    return retVec;
}

bool millerRabin(num n) {
    std::vector<num> w;
    if (n < 2047)
        return millerRabin(n, 2);
    else if (n < 9080191)
        w = {31, 73};
    else if (n < 4759123141L)
        w = {2, 7, 61};
    else if (n < 1122004669633L)
        w = {2, 13, 23, 1662803};
    else {
        std::cout << "Miller Rabin Test: Number too large for predefined witnesses!" << std::endl;
        return false;
    }

    return millerRabin(n, w);
}

bool millerRabin(num n, std::vector<num> witness) {
    for (int i = 0; i < witness.size(); ++i) {
        if (not millerRabin(n, witness[i]))
            return false;
    }
    return true;
}

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

    num x = powMod(witness, m, n);

    if (x == 1 || x == n - 1)
        return true;

    for (int r = 1; r <= k - 1; ++r) {
        x = powMod(x, 2, n);
        if (x == 1)
            return false;
        if (x == n - 1)
            return true;
    }

    return false;
}

unsigned int numLength(num n) {
    return (unsigned int) floor(log10(n)) + 1;
}

static num powMod(num a, num x, num n) {
    num r = 1;

    while (x) {
        if ((x & 1) == 1)
            r = a * r % n;

        x >>= 1;
        a     = a * a % n;
    }
    return r;
}

num rotateNumRight(num n) {

    int length = (int) floor(log10(n)) + 1;

    num lastDigit = n % 10;
    num res       = (lastDigit * (num) pow(10, length - 1)) + n / 10;

    return res;
}

std::vector<unsigned int> sieveOfEratosthenes(unsigned int n) {

    std::vector<bool>         *isPrime = new std::vector<bool>(n, true);
    std::vector<unsigned int> primes;

    // Legendre approximation
    primes.reserve(n / (log(n) - 1.08366));

    // algorithm starts at 5 so add primes before
    primes.push_back(2);
    primes.push_back(3);

    // alternate step size between 2 and 4 to avoid stepping on multiples of 2 and 3
    for (unsigned long i = 5, step = 2; i < n; i += step, step = 6 - step) {

        if (isPrime->at(i / 3)) {

            primes.push_back(i);

            for (unsigned long j = i * i, subStep = step; j < n; j += subStep * i, subStep = 6 - subStep)
                isPrime->at(j / 3) = false;
        }
    }

    return primes;
}
