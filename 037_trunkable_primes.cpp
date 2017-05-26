/*
 * The number 3797 has an interesting property. Being prime itself, it is possible to continuously remove digits
 * from left to right, and remain prime at each stage: 3797, 797, 97, and 7.
 * Similarly we can work from right to left: 3797, 379, 37, and 3.
 *
 * Find the sum of the only eleven primes that are both truncatable from left to right and right to left.
 *
 * NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.
 */

#include <iostream>
#include <set>
#include "MyLib_cpp.h"

using namespace std;

int         numbersFound = 2;
long        sumFound     = 0;
set<num>    truncatableFromLeft;
set<num>    truncatableFromLeftAndRight;
vector<num> witnesses;

void findTruncatableFromLeft(num base, int maxLength, int length) {
    if (length == maxLength)
        return;
    for (int i = 1; i < 10; ++i) {
        num tmp = base + (num) pow(10, length) * i;
        if (millerRabin(tmp, witnesses)) {
            truncatableFromLeft.insert(tmp);
            findTruncatableFromLeft(tmp, maxLength, length + 1);
        }
    }
}

void deleteUntruncatableFromRight() {
    for (num n : truncatableFromLeft) {
        num  tmp     = n;
        bool insertN = true;

        for (int length = numLength(tmp); length > 0; --length) {
            // if n is not prime
            if (not millerRabin(tmp, witnesses)) {
                insertN = false;
                break;
            }
            tmp /= 10;
        }
        if (insertN && n > 10)
            truncatableFromLeftAndRight.insert(n);
    }
}

int main(void) {

    //6: 739397
    //5: 73331X
    //4: 3137, 3797, 7331X
    //3: 311X, 313, 317, 373, 379X, 719X, 797
    //2: 23, 29X, 37, 53, 59X, 71X, 73, 79X
    int length = 6;

    int64_t w[] = {2, 3, 6};

    for (int i = 0; i < (sizeof(w) / sizeof(w[0])); ++i)
        witnesses.push_back(w[i]);


    // primes can only have last digits 1,3,7,9
    // 1 and 9 does not make sense since it is no prime
    findTruncatableFromLeft(3, length, 1);
    findTruncatableFromLeft(7, length, 1);

    deleteUntruncatableFromRight();

    int sum = 0;

    cout << truncatableFromLeftAndRight.size() << endl << endl;
    for (num n : truncatableFromLeftAndRight){
        sum += n;
        cout << n << ", ";
    }

    cout << endl << endl << "Sum = " << sum << endl;

}