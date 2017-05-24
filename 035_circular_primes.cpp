#include <iostream>
#include <array>
#include <vector>
#include <algorithm>
#include "MyLib.h"

using namespace std;

static const array<int, 4> possibleDigits = {1, 3, 7, 9};
int                        numbersFound   = 2;
vector<num>                founds;

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
