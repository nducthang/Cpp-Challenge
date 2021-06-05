#include <iostream>
#include <cstring>
using namespace std;
// KMP algorithm
#define MAX 1000005
int F[MAX]; // prefix function
char T[] = "ABABDABACDABABCABAB";
char P[] = "ABABCABAB";
int n, m; // n is length of T, m is length of P
void Prefix()
{
	int len = 0; // length of previous longest prefix suffix
	F[0] = 0; // F[0] always is 0
	int i = 1;
	// The loop calculates F[i] form 1 to m-1
	while (i < m)
	{
		if (P[i] == P[len])
		{
			len++;
			F[i] = len;
			i++;
		}
		else // P[i] != P[len]
		{
			if (len != 0)
			{
				len = F[len - 1];
			}
			else // if len==0
			{
				F[i] = 0;
				i++;
			}
		}
	}
}
void KMP()
{
	int i = 0; //index for T
	int j = 0; //index for P
	while (i<n)
	{
		if (P[j] == T[i])
		{
			j++;
			i++;
		}
		if (j == m)
		{
			cout << "Vi tri trung: " << i - m << endl;
			j = F[j - 1];
		}
		else if (i < n && P[j] != T[i])
		{
			if (j != 0)
				j = F[j - 1];
			else
				i++;
		}
	}
}
int main()
{
	n = strlen(T);
	m = strlen(P);
	Prefix();
	KMP();
}
