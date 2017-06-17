/*
 * In the 5 by 5 matrix below, the minimal path sum from the top left to the bottom right, by moving left,
 * right, up, and down, is indicated in bold red and is equal to 2297.
 *
 *  131 673 234 103  18
 *  201  96 342 965 150
 *  630 803 746 422 111
 *  537 699 497 121 956
 *  805 732 524  37 331
 *
 *   Find the minimal path sum, in matrix.txt (right click and "Save Link/Target As..."),
 *   a 31K text file containing a 80 by 80 matrix, from the top left to the bottom right
 *   by moving left, right, up, and down.
 */

#include <cstdio>
#include <map>
#include <list>
#include <algorithm>
#include <functional>
#include <fstream>
#include <sstream>
#include <vector>
#include <cmath>

using namespace std;

#define OPEN   1
#define CLOSED 2

struct node {
    unsigned int index               = 0,
                 value               = 0,
                 valueToHere         = 0;
    node         *optimalPredecessor = nullptr;
    short        visited             = 0;
};

bool compareByValueToHere(const node &a, const node &b) {
    return a.valueToHere < b.valueToHere;
}

int distanceToTarget(const node &n, const int x, const int y) {
    int n_x = n.index % x,
        n_y = n.index / y;
    return x - 1 - n_x + y - 1 - n_y;
}

bool compareByDistanceToTarget(const node &a, const node &b, const int x, const int y) {
    int dist = distanceToTarget(a, x, y) - distanceToTarget(b, x, y);
    if (dist == 0)
        return compareByValueToHere(a, b);
    return distanceToTarget(a, x, y) < distanceToTarget(b, x, y);
}

void printDirectionField(const node maze[], const unsigned int x, const unsigned int y) {
    for (unsigned int i = 0; i < x * y; ++i) {
        if (i > 0 && i % x == 0)
            printf("\n");
        if (maze[i].optimalPredecessor == nullptr)
            printf(" ");
        else if (maze[i].optimalPredecessor == &maze[i - 1])
            printf("<");
        else
            printf("^");
        printf("%3d ", maze[i].value);
    }
    printf("\n\n");
}

void expand(list <node> &openList, node &currentNode, node &nextNode, const int x, const int y) {
    // next node already visited?
    if ((nextNode.visited & CLOSED) == CLOSED)
        return;

    // potential costs to nextNode
    auto valToNext = currentNode.valueToHere + nextNode.value;

    // do nothing if there already exists a better path
    if (((nextNode.visited & OPEN) == OPEN) and valToNext >= nextNode.valueToHere)
        return;

    nextNode.optimalPredecessor = &currentNode;
    nextNode.valueToHere        = valToNext;

    if ((nextNode.visited & OPEN) != OPEN) {
        openList.push_back(nextNode);
        nextNode.visited |= OPEN;
    }
}

/**
 * Finds the shortest path (=lowest path sum) in a n by m matrix
 * @param n matrix width
 * @param m matrix height
 * @return path length
 */
unsigned int a_star(node maze[], unsigned int n, unsigned int m) {

    // list of nodes to which a (suboptimal) path is known
    list <node> openList;

    openList.push_back(maze[0]);
    maze[0].visited |= OPEN;

    while (!openList.empty()) {
        node currentNode = openList.front();
        openList.pop_front();
        // have we reached the target?
        if (currentNode.index == n * m - 1)
            return currentNode.valueToHere;


        // mark node as visited
        currentNode.visited |= CLOSED;

        // expand right
        expand(openList, maze[currentNode.index], maze[currentNode.index + 1], n, m);

        // only expand down if not last in column
        if (currentNode.index < n * (m - 1) || currentNode.index == 0) {
            expand(openList, maze[currentNode.index], maze[currentNode.index + n], n, m);
        }

        // only expand up if not in first line
        if (currentNode.index >= n) {
            expand(openList, maze[currentNode.index], maze[currentNode.index - n], n, m);
        }

        // only expand left if not in first line
        if (currentNode.index % n != 0) {
            expand(openList, maze[currentNode.index], maze[currentNode.index - 1], n, m);
        }

        // only expand right if not in first line
        if (currentNode.index - 1 % n != 0) {
            expand(openList, maze[currentNode.index], maze[currentNode.index + 1], n, m);
        }
        auto comp = bind(&compareByDistanceToTarget, placeholders::_1, placeholders::_2, n, m);
        openList.sort(compareByValueToHere);
//        printDirectionField(maze, n, m);
    }
    return -1;
}

void printPath(node maze[], int x, int y) {
    for (node *n = &maze[x * y - 1]; n != nullptr; n = n->optimalPredecessor) {
        printf("%3d <- ", n->value);
    }
}

int main() {

    vector<unsigned int> values;
    unsigned int         pathLengths = -1;
    ifstream             matrixFile("../resources/p083_matrix.txt");
    if (!matrixFile.is_open()) {
        printf("could not open file!");
        return -1;
    }

    string       line;
    string       token;
    while (getline(matrixFile, line)) {
        stringstream ssline(line);
        while (getline(ssline, token, ',')) {
            values.push_back(stoi(token));
        }
    }
    unsigned int n                   = sqrt(values.size());

    node              maze[values.size()];
    for (unsigned int i              = 0; i < n; ++i) {
        auto              start = i * n;
        for (unsigned int j     = 0; j < n; ++j) {
            for (unsigned int k      = 0; k < values.size(); ++k) {
                maze[k].value              = values[k];
                maze[k].valueToHere        = values[k];
                maze[k].index              = k;
                maze[k].optimalPredecessor = nullptr;
                maze[k].visited            = 0;
            }
            auto              target = (j + 1) * n - 1;
            pathLengths = min(pathLengths, a_star(maze, n, n));
        }
    }

    printDirectionField(maze, n, n);

    printf("Path length = %d\n", pathLengths);
//    printPath(maze, n, n);
}