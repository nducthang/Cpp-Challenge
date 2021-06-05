#include <iostream>
#include <cstring>
using namespace std;
const int MAX = 1000005;
char A[MAX],B[MAX];
int F[MAX];
int n,m; // n is length of A, m is length of B
void Prefix()
{
	int len=0;
	int i=1;
	while(i<m)
	{
		if(B[len]==B[i])
		{
			len++;
			F[i]=len;
			i++;
		}
		else
		{
			// if B[len]!=B[i]
			if(len!=0)
			{
				// backtracking
				len=F[len-1];
			}
			else
			{
				// if len == 0
				F[i]=0;
				i++;
			}
		}
	}
}
void KMP()
{
	int i=0; // i is index of A
	int j=0;// j is index of B
	while(i<n)
	{
		if(B[j]==A[i])
		{
			i++;
			j++;
		}
		if(j==m)
		{
			cout<<i-m+1<<" ";
			j=F[j-1];
		}
		else if(i<n &&  B[j]!=A[i])
		{
			if(j!=0)
				j=F[j-1];
			else
				i++;
		}
	}
}
void Enter()
{
	cin>>A>>B;
	n=strlen(A); m=strlen(B);
}
int main()
{
	Enter();
	Prefix();
	KMP();
}
