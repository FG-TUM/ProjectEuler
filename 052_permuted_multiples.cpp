/*
 * It can be seen that the number, 125874, and its double, 251748, contain exactly the same digits, but in a different order.
 *
 * Find the smallest positive integer, x, such that 2x, 3x, 4x, 5x, and 6x, contain the same digits.
 */

#include <iostream>
#include <algorithm>

#include "MyLib_cpp.h"

using namespace std;

int main() {

    for (unsigned int n = 10000; n < n*100; ++n) {
        auto digits = intToVec(n);
        sort(digits.begin(), digits.end());
        bool found = true;
        for (unsigned int i = 2; i < 6; ++i) {
            auto tmp = n * i;
            auto tmpDigits = intToVec(tmp);
            sort(tmpDigits.begin(), tmpDigits.end());
            if(digits != tmpDigits) {
                found = false;
                break;
            }

        }
        if(found) {
            cout << "Found it! " << n << endl;
            return 0;
        }
    }

    return -1;
}