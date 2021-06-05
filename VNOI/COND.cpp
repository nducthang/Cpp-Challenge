#include <iostream>
using namespace std;
long factorial[11]={1,1,2,6,24,120,720,5040,40320,362880,3628800}; // factorial[i] la i! (0<=i<=10)
long x[11],T[11]; // x[i] luu cau hinh, T[i] la tong cua cau hinh x1 den xi
long res=0; // ket qua
int n;
void Result(int i)
{
	long denominator=1;
	for(int j=1;j<=i;j++)
		denominator*=factorial[x[j]];
	res+=factorial[n]/denominator;
}
void Try(int i)
{
	// Quay lui chon x(i)
	for(int j=1;j<=n;j++)
	{
		if(T[i-1]+j<=n)
		{
			x[i]=j;
			T[i]=T[i-1]+j;
			if(T[i]==n) Result(i);
			else
				Try(i+1);
		}
	}
}

int main()
{
	T[0]=0;
	while(cin>>n && n!=-1)
	{
		// Solution
		Try(1);
		cout<<res<<endl; // print result
		res=0; // update reinit res = 0
	}
}
