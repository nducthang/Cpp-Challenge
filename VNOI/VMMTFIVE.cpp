#include <iostream>
#include <algorithm>
using namespace std;
#define MAX 30
int c[MAX][MAX];
int hang[MAX], cot[MAX];

void Try(int i, int j)
{
    if (i == 6)
    {
        if (cot[5] == 0)
        {
            for (int i = 1; i <= 5; i++)
            {
                for (int j = 1; j <= 5; j++)
                {
                    cout << c[i][j] << " ";
                }
                cout << endl;
            }
            exit(0);
        }
        return;
    }
    int l = max(1, max(hang[i] - 25 * (5 - j), cot[j] - 25 * (5 - i)));
    int r = min(25, min(hang[i] - 5 + j, cot[j] - 5 + i));
    if (l > 25 || r < 1 || l > r)
        return;
    if (j == 5)
        l = r = hang[i];

    for (int k = l; k <= r; k++)
    {

        c[i][j] = k;
        hang[i] -= k;
        cot[j] -= k;
        if (j < 5)
            Try(i, j + 1);
        else
            Try(i + 1, 1);
        hang[i] += k;
        cot[j] += k;
    }
}
int main()
{
    for (int i = 1; i <= 5; i++)
        cin >> hang[i];
    for (int i = 1; i <= 5; i++)
        cin >> cot[i];
    Try(1, 1);
}