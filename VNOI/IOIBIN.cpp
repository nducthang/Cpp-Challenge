#include <iostream>
#include <cstdio>
using namespace std;

const int N = 10000;
int s[N];
int x,y,z;

int findSet(int x) {
    return s[x] == x ? x : s[x] = findSet(s[x]);
}

void unionSet(int x, int y) {
    s[findSet(x)] = findSet(y);
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(NULL);
    for(int i = 0; i < N; ++i)
        s[i] = i;
    int p;
    cin >> p;
    for(int i = 0; i < p; ++i) {
        cin >> x >> y >> z;
        --x; --y;
        if(z == 1) {
            unionSet(x, y);
        } else {
            printf("%d\n", findSet(x) == findSet(y) ? 1 : 0);
        }
    }
    return 0;
}