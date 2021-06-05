#include <iostream>
using namespace std;
#define MAX 25005
int main()
{
	// Nhap du lieu
	long long n;
	cin>>n;
	long long L[MAX];
	for(long long i=1;i<=n-1;i++)
		cin>>L[i];
	// Quy hoach dong
	long long F[MAX];
	F[1]=0;
	F[2]=L[1];
	F[3]=L[1]+L[2];
	for(long long i=4;i<=n;i++)
		F[i]=min(F[i-1] ,F[i-2]) +L[i-1];
	cout<<F[n]<<endl;
}
