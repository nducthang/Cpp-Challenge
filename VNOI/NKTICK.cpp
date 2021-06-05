// Code by gihub @nducthang
#include <iostream>
using namespace std;
#define MAX 60001
int main()
{
	// Input data
	long N,T[MAX],R[MAX];
	cin>>N;
	for(int i=1;i<=N;i++)
		cin>>T[i];
	for(int i=1;i<=N-1;i++)
		cin>>R[i];
	// Optimize
	long long F[MAX];
	F[0]=0;
	F[1]=T[1];
	for(long i=2;i<=N;i++)
		F[i]=min(F[i-1]+T[i],F[i-2]+R[i-1]);
	cout<<F[N]<<endl;
}
