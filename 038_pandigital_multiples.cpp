/*
 * Take the number 192 and multiply it by each of 1, 2, and 3:
 *
 * 192 × 1 = 192
 * 192 × 2 = 384
 * 192 × 3 = 576
 * By concatenating each product we get the 1 to 9 pandigital, 192384576. We will call 192384576 the concatenated
 * product of 192 and (1,2,3)
 *
 * The same can be achieved by starting with 9 and multiplying by 1, 2, 3, 4, and 5, giving the pandigital, 918273645,
 * which is the concatenated product of 9 and (1,2,3,4,5).
 *
 * What is the largest 1 to 9 pandigital 9-digit number that can be formed as the concatenated product of an integer
 * with (1,2, ... , n) where n > 1?
 */
#include <set>
#include <iostream>
#include "MyLib_cpp.h"

using namespace std;

int concat(int a, int b) {
    return a * (unsigned int) pow(10, numLength(b)) + b;
}

bool isPandigital(int n) {
    if (n > 987654321 || n < 123456789)
        return false;

    set<int> digits;

    for (int i = 0; i < 9; ++i) {
        auto ret = digits.insert(n % 10);
        if (!ret.second)
            return false;
        n /= 10;
    }
    return digits.size() == 9 && digits.find(0) == digits.end();
}

int main() {

    int largestPan = 0;
    int largestN   = 0;
    int largestJ   = 0;

    for (int i = 1; i < 10000; ++i) {
        int n   = i;
        int pan = n;
        int j;
        for (j = 2; j < 10; ++j) {
            pan = concat(pan, n * j);
            if (pan >= 100000000)
                break;
        }
        if (isPandigital(pan) && pan > largestPan) {
            largestPan = pan;
            largestN   = n;
            largestJ   = j;
        }
    }

    cout << "Largest Pandigital = " << largestPan << endl;
    cout << "base               = " << largestN << endl;
    cout << "concatenations     = " << largestJ << endl;
}