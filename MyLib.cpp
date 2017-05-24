#include "MyLib.h"


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

num rotateNumRight(num n) {

    int length = (int) ceil(log10(n));

    num lastDigit = n % 10;
    num res       = (lastDigit * (num) pow(10, length - 1)) + n / 10;

    return res;
}